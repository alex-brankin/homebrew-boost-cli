class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.5/boost-cli-macos-arm64"
      sha256 "4b13f548caa6123956768cb7825cb69d8371a370e1b2cf10f89f9f8c04e28200"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.5/boost-cli-macos-x64"
      sha256 "8eb8f80544ed5ffa49bfa144d48e56a2211c2e4f58bafbf64731b1544f11e3a3"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.5/boost-cli-linux-x64"
    sha256 "44a67b49286cd080bac9061389b45a4e1740b2c42477ba31eaaac7e68b0a7a4a"
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
    assert_match "1.17.5", shell_output("#{bin}/boost-cli --version")
  end
end
