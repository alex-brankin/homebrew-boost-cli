class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.4/boost-cli-macos-arm64"
      sha256 "bd44a8c1066609b4eac23feee3c3c92e61391b435b9eab390ebd73f5ba8a30d5"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.4/boost-cli-macos-x64"
      sha256 "5b53b0c9206e8a0a2961fd97b3a7e7cd57938564f276782c8d681a0404b57741"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.4/boost-cli-linux-x64"
    sha256 "7b064840c57d876d2138f6397335942b96c49aafc18f475aa2d11b785fb007f7"
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
    assert_match "1.17.4", shell_output("#{bin}/boost-cli --version")
  end
end
