class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.25.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.25.0/boost-cli-macos-arm64"
      sha256 "544d5d3c30f5dc05c553c7addeafe094ffde1424fef3e923d0245a13348bb23a"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.25.0/boost-cli-macos-x64"
      sha256 "5658bff45a49099166541d8050ad2ec00a92df3f65ded65274088d14671f5335"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.25.0/boost-cli-linux-x64"
    sha256 "a9f70c0aee05ee4d9d1886dc36b686e05747c5db6540b30ba16dbc14b6a46c0d"
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
    assert_match "1.25.0", shell_output("#{bin}/boost-cli --version")
  end
end
