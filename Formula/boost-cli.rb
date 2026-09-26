class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.6/boost-cli-macos-arm64"
      sha256 "bfdb2a539c4255dc48f0278cc5752aa38d3f971a73bdbb1ba430978c66e075c7"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.6/boost-cli-macos-x64"
      sha256 "2ffcc15a3b193fcb75de58aef6410d7d4034626fbe6c5ec8e333e6f37c505b3c"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.6/boost-cli-linux-x64"
    sha256 "599341dd5650cd3cf33d050e0aa63165b0c452c17db641827fea62ad28017cee"
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
    assert_match "1.17.6", shell_output("#{bin}/boost-cli --version")
  end
end
