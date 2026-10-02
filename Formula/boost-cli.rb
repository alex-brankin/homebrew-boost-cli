class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.27.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.27.0/boost-cli-macos-arm64"
      sha256 "5433056fdb1b985ecce409c92b568c71b88afdf3582476b08f6827aaac5b7957"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.27.0/boost-cli-macos-x64"
      sha256 "f2b39ee2a125461b7f58eb30da75efcf999459d64763d1fcf4c890eeb7593b08"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.27.0/boost-cli-linux-x64"
    sha256 "2c9f479eeef5a25868469b8da0b4c68991240187edb101796be4f1cdaab4e92a"
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
    assert_match "1.27.0", shell_output("#{bin}/boost-cli --version")
  end
end
