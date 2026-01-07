class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-sync-cli"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/boost-sync-cli/releases/download/v1.0.0/boost-cli-macos-arm64"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    else
      url "https://github.com/alex-brankin/boost-sync-cli/releases/download/v1.0.0/boost-cli-macos-x64"
      sha256 "PLACEHOLDER_X64_SHA256"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/boost-sync-cli/releases/download/v1.0.0/boost-cli-linux-x64"
    sha256 "PLACEHOLDER_LINUX_SHA256"
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
    system "#{bin}/boost-cli", "--version"
  end
end
