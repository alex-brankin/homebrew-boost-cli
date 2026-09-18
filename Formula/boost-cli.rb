class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.13.0/boost-cli-macos-arm64"
      sha256 "3a1de5d102cfd792598692490ba336e7f1c693ca8529f6b5d75a3f7d94058ccf"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.13.0/boost-cli-macos-x64"
      sha256 "4c730ef53a44016f2cabcd05ec09ddc9ae8ba8523803b814abc0e5b8c1eb2176"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.13.0/boost-cli-linux-x64"
    sha256 "520164ae59e41445c0adb99d78a18d1b11f96dc14bf84562d79e22f6135fa93c"
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
    assert_match "1.13.0", shell_output("#{bin}/boost-cli --version")
  end
end
