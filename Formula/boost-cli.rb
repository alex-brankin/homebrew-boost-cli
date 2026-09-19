class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.14.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.2/boost-cli-macos-arm64"
      sha256 "e182a8a6931c5ef4eec0910de2d7e955ff1a942cdb14b2f7d8cd182ed58a2b71"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.2/boost-cli-macos-x64"
      sha256 "47c926b142fb19c0af1986015ca7c279cad5d5eddf955d10ca2b65e678a72e8f"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.2/boost-cli-linux-x64"
    sha256 "af856c985f08709ead85021a9689a68b2765619812490661a23652f6399c0f8a"
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
    assert_match "1.14.2", shell_output("#{bin}/boost-cli --version")
  end
end
