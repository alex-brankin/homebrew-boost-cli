class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.6.0/boost-cli-macos-arm64"
      sha256 "8e49f9e29c5b56efab022daad72f489325a97285694fff6ce83edde2ed83d6cd"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.6.0/boost-cli-macos-x64"
      sha256 "47022c2f6a6a1b0489557f8bcc1569e9587316f567d0e73dd0b84d4a7c803e77"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.6.0/boost-cli-linux-x64"
    sha256 "b309c2e3fe32a117fe9a5e7e711319476ef2ee64641269e9628b86a32b040163"
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
    assert_match "1.6.0", shell_output("#{bin}/boost-cli --version")
  end
end
