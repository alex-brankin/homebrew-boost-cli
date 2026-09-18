class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.14.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.0/boost-cli-macos-arm64"
      sha256 "a0bcaa190546bbb661414e87696a091d2795175a39a04774b7c461a2a2093c48"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.0/boost-cli-macos-x64"
      sha256 "32a54f50134ac3e1221f529778dead3c84c0b87b7e62756e5199066be17514bc"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.14.0/boost-cli-linux-x64"
    sha256 "ff1cf9cdc4bcb10cbdd4c6af730864c51c55c9ee2456177aa9aa7342aeed43da"
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
    assert_match "1.14.0", shell_output("#{bin}/boost-cli --version")
  end
end
