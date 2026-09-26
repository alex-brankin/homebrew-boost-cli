class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.8/boost-cli-macos-arm64"
      sha256 "05ebad36388bc5c7d2a9539c61b4c2222d4507c3f4a9fc2753c12dd4230382c4"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.8/boost-cli-macos-x64"
      sha256 "0c421e554667e4790ea405c56cb1ca27c146b0266300a3b43d71660128cb5109"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.8/boost-cli-linux-x64"
    sha256 "b7a2f7e8b52bac94c40d4f89677975ee126bc835519af38cc74b1c55a77b6bd8"
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
    assert_match "1.17.8", shell_output("#{bin}/boost-cli --version")
  end
end
