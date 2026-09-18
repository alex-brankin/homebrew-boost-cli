class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.12.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.12.1/boost-cli-macos-arm64"
      sha256 "214e4a9549c833bb7a27fcd4ad6b18fcdc13c546bde6695c4ded834bb4284f1b"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.12.1/boost-cli-macos-x64"
      sha256 "e27c12c9eefc1e33006f96f75d093535140d6f96f449e1d1d09f28cd98843891"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.12.1/boost-cli-linux-x64"
    sha256 "dc46573861a61f79e257eabd612ea2e78a53cada1e430787fe6491010769edf5"
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
    assert_match "1.12.1", shell_output("#{bin}/boost-cli --version")
  end
end
