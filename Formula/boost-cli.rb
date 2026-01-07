class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-sync-cli"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.0/boost-cli-macos-arm64"
      sha256 "975875bab64fbab1490cf651136ec88eccda2d3c7a49cc83b8466ecd9ab568c1"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.0/boost-cli-macos-x64"
      sha256 "136effdd1eecd411c6e62c847287515f1bf96e230046029007dd61dc913a684c"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.0/boost-cli-linux-x64"
    sha256 "580ec06a4f95444e0e7cd6fdb6ae08d336a8fe376dcba8e7fa66f5aa98aaab2a"
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
    system "#{bin}/boost-cli", "--version"
  end
end
