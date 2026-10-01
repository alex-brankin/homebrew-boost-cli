class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.20.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.20.1/boost-cli-macos-arm64"
      sha256 "3a3daf54e54d8bb17be72ad9a343c674eb64304e501c475e840365a6844db52e"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.20.1/boost-cli-macos-x64"
      sha256 "30a4b48acc106e8177a450091cfc69304e7cfbc1a9c4aa22c0ddf8af7b342ed9"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.20.1/boost-cli-linux-x64"
    sha256 "adf843e1d594375d5b274b87ab0a7dfb969e1a4f3fd53b3cbc80427544c23ed1"
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
    assert_match "1.20.1", shell_output("#{bin}/boost-cli --version")
  end
end
