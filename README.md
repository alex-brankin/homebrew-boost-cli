# Homebrew Tap for Boost CLI

Official Homebrew tap for [Boost CLI](https://github.com/alex-brankin/boost-sync-cli) - a command-line tool for syncing Boost Commerce templates.

## Installation

```bash
# Add the tap
brew tap alex-brankin/boost-cli

# Install boost-cli
brew install boost-cli

# Verify installation
boost-cli --version
```

## Updating

```bash
brew upgrade boost-cli
```

## Uninstalling

```bash
brew uninstall boost-cli
brew untap alex-brankin/boost-cli
```

## What gets installed?

This tap installs **pre-compiled binaries** (not source code). The CLI is built using `pkg` and distributed as standalone executables:

- **macOS ARM64** (M1/M2/M3 Macs)
- **macOS x64** (Intel Macs)
- **Linux x64**

No source code is exposed. The binaries are downloaded from [GitHub Releases](https://github.com/alex-brankin/boost-sync-cli/releases).

## Security

The binaries are:
- ✅ Downloaded directly from official GitHub releases
- ✅ Verified with SHA256 checksums
- ✅ No code signing required (Homebrew handles permissions)
- ✅ Source code protected (compiled with `pkg`)

## Support

For issues, feature requests, or questions:
- **GitHub Issues**: https://github.com/alex-brankin/boost-sync-cli/issues
- **Main Repository**: https://github.com/alex-brankin/boost-sync-cli
