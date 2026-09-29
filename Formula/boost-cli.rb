class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.18.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.18.1/boost-cli-macos-arm64"
      sha256 "a40e9223bccb65717c7eb7a6108682abe35cd4353a357eca5f5e685d88822825"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.18.1/boost-cli-macos-x64"
      sha256 "87b806858eaea617e478fe7479b40e5a4dbb38311e3dd29e46a87f636f37017f"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.18.1/boost-cli-linux-x64"
    sha256 "f1be0f0ee989fc38cb6a64d73d585f09e9286b814b2cdfd5aaa81f81a804fe47"
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
    assert_match "1.18.1", shell_output("#{bin}/boost-cli --version")
  end
end
