class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.21.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.21.0/boost-cli-macos-arm64"
      sha256 "cd80f3a1f16d6c44af147800bb22b41caccba932eeb9dd83492a2827b6d1b4ba"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.21.0/boost-cli-macos-x64"
      sha256 "bbdf0b5e19c4c998183d4bedb7cd92d3226cc4f8c0670450245a8b43ae05963a"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.21.0/boost-cli-linux-x64"
    sha256 "316994d52ec4d2b67f2e06d288efbf9458ddf6d9ec91ec8d626901f9271813ec"
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
    assert_match "1.21.0", shell_output("#{bin}/boost-cli --version")
  end
end
