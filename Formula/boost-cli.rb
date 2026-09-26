class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.9/boost-cli-macos-arm64"
      sha256 "e4d5003468abfb4130ab86bad7e856448c15d2efae44ddce1932be9b0ed742ba"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.9/boost-cli-macos-x64"
      sha256 "31038a4d458fdebbe96087692aa179790c2e16291fbf0b5aa66b0e2b1d9986fc"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.9/boost-cli-linux-x64"
    sha256 "f076a50091be1bd51da399b40a4c3185d3d43a33db4f11c2e53e5f1a9650ba58"
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
    assert_match "1.17.9", shell_output("#{bin}/boost-cli --version")
  end
end
