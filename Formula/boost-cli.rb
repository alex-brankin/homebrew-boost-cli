class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.10.0/boost-cli-macos-arm64"
      sha256 "03a0484c8a74c896d426acbe107ab7118284f6d877f708c7e158735bf78933eb"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.10.0/boost-cli-macos-x64"
      sha256 "2e221962456f8d475890cb04f25db9eb293a676781ee7a63baa716187330f043"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.10.0/boost-cli-linux-x64"
    sha256 "464e40d839611222b9d4f3268b084a8397acff6120dda582d4ec5b0bbc02eb12"
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
    assert_match "1.10.0", shell_output("#{bin}/boost-cli --version")
  end
end
