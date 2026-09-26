class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.0/boost-cli-macos-arm64"
      sha256 "d62824d8a5355f113349b8a363bc7981bb6cacc71ca9926fa09920085ed24af7"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.0/boost-cli-macos-x64"
      sha256 "6b1706c30f0e5a75187b78187f37a7971ff4ee1d5ab455a4ecdab75df82dc89e"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.0/boost-cli-linux-x64"
    sha256 "819ab4de2ea7594ba0d6e0bbd8d185a78866fe9dec5c67ee22012c81b354e89f"
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
    assert_match "1.17.0", shell_output("#{bin}/boost-cli --version")
  end
end
