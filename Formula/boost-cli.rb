class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.28.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.28.0/boost-cli-macos-arm64"
      sha256 "3c490bb9caefbc7be2f34b951c968ba50eaa307086217dc3cdd865ae8d214887"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.28.0/boost-cli-macos-x64"
      sha256 "0fa9ced743482689d59b35ba52de040beb14a9e1b48e0aaa80c77a1d51910b9c"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.28.0/boost-cli-linux-x64"
    sha256 "9b14e8935965772ac379c759a6bbd1f234db98a2471074a4543281a1a6dff771"
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
    assert_match "1.28.0", shell_output("#{bin}/boost-cli --version")
  end
end
