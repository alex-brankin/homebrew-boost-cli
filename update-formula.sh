#!/bin/bash
# Helper script to update the Homebrew formula with new release SHA256 hashes

VERSION=${1:-1.0.0}

echo "📦 Updating Homebrew formula for version $VERSION"
echo ""

# Check if binaries exist in the main repo dist folder
MAIN_REPO="../boost-sync-cli/dist"

if [ ! -d "$MAIN_REPO" ]; then
  echo "❌ Error: dist/ folder not found in boost-sync-cli"
  echo "   Run 'npm run build:all' first to generate binaries"
  exit 1
fi

echo "🔐 Calculating SHA256 checksums..."

# Calculate SHA256 for each binary
ARM64_SHA=$(shasum -a 256 "$MAIN_REPO/boost-cli-macos-arm64" | cut -d' ' -f1)
X64_SHA=$(shasum -a 256 "$MAIN_REPO/boost-cli-macos-x64" | cut -d' ' -f1)
LINUX_SHA=$(shasum -a 256 "$MAIN_REPO/boost-cli-linux-x64" | cut -d' ' -f1)

echo "   ARM64:  $ARM64_SHA"
echo "   x64:    $X64_SHA"
echo "   Linux:  $LINUX_SHA"
echo ""

# Update the formula file
sed -i.bak "s/version \".*\"/version \"$VERSION\"/" Formula/boost-cli.rb
sed -i.bak "s|/v[0-9.]*\/|/v$VERSION/|g" Formula/boost-cli.rb
sed -i.bak "s/PLACEHOLDER_ARM64_SHA256/$ARM64_SHA/" Formula/boost-cli.rb
sed -i.bak "s/PLACEHOLDER_X64_SHA256/$X64_SHA/" Formula/boost-cli.rb
sed -i.bak "s/PLACEHOLDER_LINUX_SHA256/$LINUX_SHA/" Formula/boost-cli.rb

# Remove backup file
rm Formula/boost-cli.rb.bak

echo "✅ Formula updated successfully!"
echo ""
echo "📝 Next steps:"
echo "   1. Commit the changes: git add Formula/boost-cli.rb && git commit -m 'Update to v$VERSION'"
echo "   2. Push to GitHub: git push origin main"
echo ""
echo "🍺 Users can install with:"
echo "   brew tap alex-brankin/boost-cli"
echo "   brew install boost-cli"
