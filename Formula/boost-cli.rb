class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-sync-cli"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.0/boost-cli-macos-arm64"
      sha256 "9bb53075fcd11a75215a8e2239dd87d97f7a617a05cac3b78e6f2a4219eed687"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.0/boost-cli-macos-x64"
      sha256 "2128471f2d98e1a944ce7c1dc48da10d966a9d53fead8410f9f99d7efc24e191"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.0/boost-cli-linux-x64"
    sha256 "4ad07f3e334db61f7e8528c0fa387f5343ffba5c03833ddc4f155c7d44a187de"
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
