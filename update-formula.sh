#!/bin/bash
# Regenerate the Homebrew formula for a new release.
#
# This used to patch the existing formula with sed, substituting
# PLACEHOLDER_*_SHA256 tokens. Those tokens only exist in a pristine formula, so
# on an already-released formula the version and URLs were rewritten while the
# OLD checksums were left in place - producing a formula that always fails
# installation with a SHA256 mismatch. The formula is now generated in full, so
# running this twice gives the same result.

set -euo pipefail

VERSION=${1:-}
if [ -z "$VERSION" ]; then
  echo "Usage: ./update-formula.sh <version>   (e.g. ./update-formula.sh 1.0.3)"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MAIN_REPO="$SCRIPT_DIR/../boost-sync-cli/dist"
RELEASE_DIR="$SCRIPT_DIR/releases/v$VERSION"
FORMULA="$SCRIPT_DIR/Formula/boost-cli.rb"

echo "📦 Updating Homebrew formula for version $VERSION"
echo ""

if [ ! -d "$MAIN_REPO" ]; then
  echo "❌ Error: dist/ folder not found at $MAIN_REPO"
  echo "   Run 'npm run build:all' first to generate binaries"
  exit 1
fi

for f in boost-cli-macos-arm64 boost-cli-macos-x64 boost-cli-linux-x64; do
  if [ ! -f "$MAIN_REPO/$f" ]; then
    echo "❌ Error: missing binary $MAIN_REPO/$f"
    exit 1
  fi
done

# Verify the binaries actually report the version being released
BUILT_VERSION="$("$MAIN_REPO/boost-cli-macos-arm64" --version 2>/dev/null || echo 'unknown')"
if [ "$BUILT_VERSION" != "$VERSION" ]; then
  echo "❌ Error: binaries report version '$BUILT_VERSION' but you asked for '$VERSION'."
  echo "   Bump package.json and re-run 'npm run build:all'."
  exit 1
fi
echo "✅ Binaries report version $BUILT_VERSION"

echo ""
echo "📁 Staging binaries into releases/v$VERSION/"
mkdir -p "$RELEASE_DIR"
cp "$MAIN_REPO/boost-cli-macos-arm64" "$RELEASE_DIR/"
cp "$MAIN_REPO/boost-cli-macos-x64"   "$RELEASE_DIR/"
cp "$MAIN_REPO/boost-cli-linux-x64"   "$RELEASE_DIR/"
[ -f "$MAIN_REPO/boost-cli-win-x64.exe" ] && cp "$MAIN_REPO/boost-cli-win-x64.exe" "$RELEASE_DIR/"

echo ""
echo "🔐 Calculating SHA256 checksums..."
ARM64_SHA=$(shasum -a 256 "$RELEASE_DIR/boost-cli-macos-arm64" | cut -d' ' -f1)
X64_SHA=$(shasum -a 256 "$RELEASE_DIR/boost-cli-macos-x64"   | cut -d' ' -f1)
LINUX_SHA=$(shasum -a 256 "$RELEASE_DIR/boost-cli-linux-x64" | cut -d' ' -f1)
echo "   ARM64:  $ARM64_SHA"
echo "   x64:    $X64_SHA"
echo "   Linux:  $LINUX_SHA"

BASE_URL="https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v$VERSION"

cat > "$FORMULA" <<FORMULA_EOF
class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-sync-cli"
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

echo ""
echo "✅ Formula regenerated for v$VERSION"
echo ""
echo "📝 Next steps:"
echo "   1. git add Formula/boost-cli.rb releases/v$VERSION"
echo "   2. git commit -m 'Release v$VERSION'"
echo "   3. git push origin main"
