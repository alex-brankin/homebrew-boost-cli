class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.31.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.31.0/boost-cli-macos-arm64"
      sha256 "660f765081f79db68be28892f40977efba577f08b33d508fd7df05c06b68c7d1"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.31.0/boost-cli-macos-x64"
      sha256 "1fe0446faa42508406b092c778e6c5d465d25d34646e16624e27e4648405b8fd"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.31.0/boost-cli-linux-x64"
    sha256 "83e06878617ea9c07dcbc028d8a16561883982787ad073f57a1821921a0db7cd"
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
    assert_match "1.31.0", shell_output("#{bin}/boost-cli --version")
  end
end
