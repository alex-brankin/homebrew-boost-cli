class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.23.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.23.0/boost-cli-macos-arm64"
      sha256 "f4a7dee2f30e17de78a7d867cb6b6779b06e6a847525f10feab49bf2c41b6b19"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.23.0/boost-cli-macos-x64"
      sha256 "dff869164672f9d87da4a321ac370c83711c3987496a2fd7a96f4d9f539c2e84"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.23.0/boost-cli-linux-x64"
    sha256 "e319b3ee621e72c71d09ba192abf5d030cb09d2a7c7c7a87ba753973e84806ab"
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
    assert_match "1.23.0", shell_output("#{bin}/boost-cli --version")
  end
end
