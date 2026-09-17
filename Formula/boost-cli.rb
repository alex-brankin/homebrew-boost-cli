class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.9.0/boost-cli-macos-arm64"
      sha256 "9b76510a1c914c3a4939dc5fb4d37e2d87d446692ba50f5d8f1a74c20f527e7e"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.9.0/boost-cli-macos-x64"
      sha256 "7416407920ee6f9fc97491e90d447dc452c80672453f41f8d2138a4335cb0323"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.9.0/boost-cli-linux-x64"
    sha256 "5f94938033eb23a9938b2550e35c4d60a96a6c03774e0a87b717416d579781d1"
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
    assert_match "1.9.0", shell_output("#{bin}/boost-cli --version")
  end
end
