class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.12.0/boost-cli-macos-arm64"
      sha256 "165acc72bce4278da3e416550af3ae782e1411e5b7d908727693a35d10cb363b"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.12.0/boost-cli-macos-x64"
      sha256 "0df4c92e1cea08f4ad5aee74cb82310d6e9e0bfb8a76f1b7f14ae45fca0e3f6b"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.12.0/boost-cli-linux-x64"
    sha256 "485250dfba50d267a0ada19ea96e34d4397043afd0eac9e8a53177d0b6df4edf"
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
    assert_match "1.12.0", shell_output("#{bin}/boost-cli --version")
  end
end
