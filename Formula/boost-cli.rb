class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.18.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.18.0/boost-cli-macos-arm64"
      sha256 "d5e1bb807724fd8815a9a168f5e3a6ee8bf8e37a2f692b0c5dfaea4e264e36c8"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.18.0/boost-cli-macos-x64"
      sha256 "115293fce7fe8a5251425e54c7b40bf9adc77c8526f05fe87e1ba1a0cf66fae2"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.18.0/boost-cli-linux-x64"
    sha256 "2e2a325a224492d5cfa383548ff941b3a67a121fc5f4a8dbc2294998e04b185c"
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
    assert_match "1.18.0", shell_output("#{bin}/boost-cli --version")
  end
end
