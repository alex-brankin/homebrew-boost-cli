class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-sync-cli"
  version "1.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.5.0/boost-cli-macos-arm64"
      sha256 "1dcfdebf3a80f6c5785b06aa2604aca0f8a3708c91d97651d8250a8bb4b7991c"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.5.0/boost-cli-macos-x64"
      sha256 "3792a07c911aedc44ce9af459fd41a01853c5e10ffb94b0a23745ed7ae445f70"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.5.0/boost-cli-linux-x64"
    sha256 "07024c9e4c0726becada77029d3f09ee207f7a1c42675f737e5098976537dfad"
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
    assert_match "1.5.0", shell_output("#{bin}/boost-cli --version")
  end
end
