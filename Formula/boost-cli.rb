class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.1/boost-cli-macos-arm64"
      sha256 "0e1f5e41aca989048981b3603586ab4121f87e9f94c8a15534a1862f2f99608d"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.1/boost-cli-macos-x64"
      sha256 "b5ceb92011a2ca0ac1a598c9acfde06c07218872ffb14a75d79761fe7a14cd74"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.1/boost-cli-linux-x64"
    sha256 "d94db4d1d5fc29072061a40c1ed4552a711bc83d579a7033962713bd84119063"
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
    assert_match "1.17.1", shell_output("#{bin}/boost-cli --version")
  end
end
