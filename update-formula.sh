#!/bin/bash
# Regenerate the Homebrew formula for a new release.
#
# Two lessons are baked in.
#
# 1. The formula is generated IN FULL. This used to patch the existing file with
#    sed against PLACEHOLDER_*_SHA256 tokens, which only exist in a pristine
#    formula - so on an already-released formula the version and URLs were
#    rewritten while the OLD checksums stayed, producing a formula that always
#    failed with a SHA256 mismatch.
#
# 2. Binaries are published as GitHub RELEASE ASSETS, not committed to the repo.
#    Each release is ~200MB across four targets, and git keeps every byte
#    forever: committing them grew the tap without bound and tripped GitHub's
#    50MB file warning on every push. Release assets are served from the same
#    host, cost nothing in history, and can be replaced.
#
# The checksums in the formula are verified against the assets as GitHub serves
# them, not against the local files, so a truncated or failed upload fails here
# rather than for whoever runs `brew install`.

set -euo pipefail

VERSION=${1:-}
if [ -z "$VERSION" ]; then
  echo "Usage: ./update-formula.sh <version>   (e.g. ./update-formula.sh 1.6.0)"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST="$SCRIPT_DIR/../boost-sync-cli/dist"
STAGING="$SCRIPT_DIR/.release-staging/v$VERSION"
FORMULA="$SCRIPT_DIR/Formula/boost-cli.rb"
TAP_REPO="alex-brankin/homebrew-boost-cli"
TAG="v$VERSION"

BINARIES=(boost-cli-macos-arm64 boost-cli-macos-x64 boost-cli-linux-x64)

echo "📦 Releasing boost-cli $VERSION"
echo ""

command -v gh >/dev/null 2>&1 || { echo "❌ gh CLI is required: https://cli.github.com"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "❌ gh is not authenticated. Run 'gh auth login'."; exit 1; }

[ -d "$DIST" ] || { echo "❌ dist/ not found at $DIST — run 'npm run build:all' first"; exit 1; }

for f in "${BINARIES[@]}"; do
  [ -f "$DIST/$f" ] || { echo "❌ missing binary $DIST/$f"; exit 1; }
done

# Refuse to publish binaries that disagree with the version being released.
BUILT_VERSION="$("$DIST/boost-cli-macos-arm64" --version 2>/dev/null || echo 'unknown')"
if [ "$BUILT_VERSION" != "$VERSION" ]; then
  echo "❌ binaries report '$BUILT_VERSION' but you asked for '$VERSION'."
  echo "   Bump package.json and re-run 'npm run build:all'."
  exit 1
fi
echo "✅ Binaries report version $BUILT_VERSION"

echo ""
echo "📁 Staging"
rm -rf "$STAGING"
mkdir -p "$STAGING"
for f in "${BINARIES[@]}"; do cp "$DIST/$f" "$STAGING/"; done
[ -f "$DIST/boost-cli-win-x64.exe" ] && cp "$DIST/boost-cli-win-x64.exe" "$STAGING/"

echo ""
echo "☁️  Publishing release assets to $TAP_REPO@$TAG"
if gh release view "$TAG" --repo "$TAP_REPO" >/dev/null 2>&1; then
  echo "   release exists - replacing assets"
  gh release upload "$TAG" "$STAGING"/* --repo "$TAP_REPO" --clobber
else
  gh release create "$TAG" "$STAGING"/* \
    --repo "$TAP_REPO" \
    --title "boost-cli $VERSION" \
    --notes "Homebrew: \`brew update && brew upgrade boost-cli\`"
fi

BASE_URL="https://github.com/$TAP_REPO/releases/download/$TAG"

echo ""
echo "🔐 Verifying checksums against the PUBLISHED assets"

# macOS ships bash 3.2, which has no associative arrays (`declare -A`), so the
# three checksums are plain variables. Do not "tidy" this into a hash.
verify_asset() {
  local f="$1"
  local local_sha remote_sha
  local_sha=$(shasum -a 256 "$STAGING/$f" | cut -d' ' -f1)
  remote_sha=$(curl -fsSL "$BASE_URL/$f" | shasum -a 256 | cut -d' ' -f1)
  if [ -z "$remote_sha" ] || [ "$local_sha" != "$remote_sha" ]; then
    echo "❌ $f: published asset does not match the local file" >&2
    echo "     local  $local_sha" >&2
    echo "     remote ${remote_sha:-<download failed>}" >&2
    exit 1
  fi
  echo "   ✓ $f  ${remote_sha:0:16}…" >&2
  printf '%s' "$remote_sha"
}

ARM64_SHA=$(verify_asset boost-cli-macos-arm64)
X64_SHA=$(verify_asset boost-cli-macos-x64)
LINUX_SHA=$(verify_asset boost-cli-linux-x64)

cat > "$FORMULA" <<FORMULA_EOF
class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "$VERSION"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "$BASE_URL/boost-cli-macos-arm64"
      sha256 "$ARM64_SHA"
    else
      url "$BASE_URL/boost-cli-macos-x64"
      sha256 "$X64_SHA"
    end
  end

  on_linux do
    url "$BASE_URL/boost-cli-linux-x64"
    sha256 "$LINUX_SHA"
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "boost-cli-macos-arm64" => "boost-cli"
      else
        bin.install "boost-cli-macos-x64" => "boost-cli"
      end
    elsif OS.linux?
      bin.install "boost-cli-linux-x64" => "boost-cli"
    end
  end

  test do
    assert_match "$VERSION", shell_output("#{bin}/boost-cli --version")
  end
end
FORMULA_EOF

rm -rf "$STAGING"

echo ""
echo "✅ Formula regenerated for $TAG, pointing at release assets"
echo ""
echo "📝 Commit the formula only - no binaries go into the repo any more:"
echo "     git add Formula/boost-cli.rb"
echo "     git commit -m 'Release $VERSION'"
echo "     git push origin main"
