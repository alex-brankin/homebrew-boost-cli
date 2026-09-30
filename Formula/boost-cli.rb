class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.20.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.20.0/boost-cli-macos-arm64"
      sha256 "c491eef7665a97035594f5e2e4b781ec7e997dc72bb3a7f4cb9bae41ec182197"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.20.0/boost-cli-macos-x64"
      sha256 "a58f056be19bff74ea2a29591a7657d8e2b5904c4813c8553ed2e1aa9da724d8"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.20.0/boost-cli-linux-x64"
    sha256 "0cedb22b805764851f1a518bdfb337f3c0d8505c5402e3e9a8d504bd298065c2"
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
    assert_match "1.20.0", shell_output("#{bin}/boost-cli --version")
  end
end
