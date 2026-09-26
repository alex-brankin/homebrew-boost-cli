class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.3/boost-cli-macos-arm64"
      sha256 "f601ccf20df83c75981c94628a2a5a0007268ce2049eef19f6a05420e33414d9"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.3/boost-cli-macos-x64"
      sha256 "6fc6823d473271c4f1417a1346312374cec2b83da8a71a0a7fa383149bf56b80"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.3/boost-cli-linux-x64"
    sha256 "32d2fc237b37224da0e98e3f330b9f5f36d6445c744c18bb2e6eb606b564e6e9"
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
    assert_match "1.17.3", shell_output("#{bin}/boost-cli --version")
  end
end
