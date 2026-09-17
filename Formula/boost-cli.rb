class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.8.0/boost-cli-macos-arm64"
      sha256 "0ed11d3723ddbf82ef90b8314808f8f34b3ffbbcfef47437853581352f2c495c"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.8.0/boost-cli-macos-x64"
      sha256 "2f4f281a007b34d70cf169ac326108c7d93480efa293d46d21c4bb6a262eaffb"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.8.0/boost-cli-linux-x64"
    sha256 "a980c39251f5b76304365997474ff08582d32b6dcd5f99eba0724cf50ec3606c"
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
    assert_match "1.8.0", shell_output("#{bin}/boost-cli --version")
  end
end
