class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.16.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.16.1/boost-cli-macos-arm64"
      sha256 "df77fdee57086e5578ad5e7df278a7843116b81c6637a28e1920b42192d376bc"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.16.1/boost-cli-macos-x64"
      sha256 "d0949ad72f8d423bee26c0fe0a464a292ed3af2dead41059db2135d1064b18c8"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.16.1/boost-cli-linux-x64"
    sha256 "5e2f37255451643b197a2e18ba6bd71c4172f2cb14e8ebd7cfd1dfad88d9c3a4"
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
    assert_match "1.16.1", shell_output("#{bin}/boost-cli --version")
  end
end
