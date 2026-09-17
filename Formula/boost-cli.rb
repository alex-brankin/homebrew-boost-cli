class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.7.0/boost-cli-macos-arm64"
      sha256 "6f83db0e90794acdf24751907100bed4f632fa10f17292bcb9bcffa012a97252"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.7.0/boost-cli-macos-x64"
      sha256 "95eea020c27de9ce3a0967dd5915946129d8a17697ac0ae9a443c51dad62c25a"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.7.0/boost-cli-linux-x64"
    sha256 "8b296de0618a5f3af77f25f6a9eb0feba5ff7bd73f2fa7fb01df391d35a3bc47"
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
    assert_match "1.7.0", shell_output("#{bin}/boost-cli --version")
  end
end
