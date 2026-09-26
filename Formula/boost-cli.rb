class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.2/boost-cli-macos-arm64"
      sha256 "a770a75c5b1e495bf663cda4ad1429c6a2b29f359f79d291b2136ea9715f2f3a"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.2/boost-cli-macos-x64"
      sha256 "2952143379f5f60283fae0609e65171d4e036f00732e506b90642e6091ba0cff"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.2/boost-cli-linux-x64"
    sha256 "f5c6e58d5a73714944e3eec204ad73792747146e30bf4af0ce2ef675a4b02b85"
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
    assert_match "1.17.2", shell_output("#{bin}/boost-cli --version")
  end
end
