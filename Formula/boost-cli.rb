class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.29.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.29.0/boost-cli-macos-arm64"
      sha256 "28e822dce0852705aa421cff666865ffc8007f14418212a0dc3d2fa152adcb1a"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.29.0/boost-cli-macos-x64"
      sha256 "e4419c29496e160e7280d28f10f23da24a00f1fff6a9ac296f79ed888132305c"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.29.0/boost-cli-linux-x64"
    sha256 "1d16f6238f721cfbea4bca1926271dd02ec0d1cd89aaedec7f2df499c624d07c"
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
    assert_match "1.29.0", shell_output("#{bin}/boost-cli --version")
  end
end
