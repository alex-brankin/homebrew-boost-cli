class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.26.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.26.0/boost-cli-macos-arm64"
      sha256 "c8e6b48819e9ac67683dc5bfc852d40f9546df5793d899888cafbb344eb215d4"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.26.0/boost-cli-macos-x64"
      sha256 "4d6159b25243331a5c9fefb1f6fe04133b537e4b31f725568c1ae36fb10289a8"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.26.0/boost-cli-linux-x64"
    sha256 "a246b0e5b99bca5cf7d3f005345533ddff4e58f1a8089a5e80e3ee54d7356ed6"
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
    assert_match "1.26.0", shell_output("#{bin}/boost-cli --version")
  end
end
