class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.11.0/boost-cli-macos-arm64"
      sha256 "bf6f8a697b21db5cd70e4cae5a029f74b66ff78d815a7b0243bcd21db120a826"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.11.0/boost-cli-macos-x64"
      sha256 "5657c0837404c2beff583168a00fdeea23c44074d1dcd15b2dd41dc13b315815"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.11.0/boost-cli-linux-x64"
    sha256 "053b86c1f845a529c73f3b2155e2965a3f1abf718bf339de1f9fb181c8236452"
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
    assert_match "1.11.0", shell_output("#{bin}/boost-cli --version")
  end
end
