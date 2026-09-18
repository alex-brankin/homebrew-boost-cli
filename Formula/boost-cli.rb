class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.14.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.1/boost-cli-macos-arm64"
      sha256 "6b6486925af04b1ede15c27f9abd39d47723ab00a1c969cd7543df360c2fedd8"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.1/boost-cli-macos-x64"
      sha256 "25ca387a7eadde31a3858d7bbc1e6ff820fb5617220eabe8b8fad6da1b2a0a87"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.1/boost-cli-linux-x64"
    sha256 "658cea9e1d9b7a28cfcead519665855ba725670150a9b0cd8f182bc819eeb038"
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
    assert_match "1.14.1", shell_output("#{bin}/boost-cli --version")
  end
end
