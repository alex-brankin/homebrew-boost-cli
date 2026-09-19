class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.16.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.16.0/boost-cli-macos-arm64"
      sha256 "b44774288add3f16b73f177a5db0989307f6c6d801b4c771f7cf33a41b09f394"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.16.0/boost-cli-macos-x64"
      sha256 "1ba116aaa08b28460700b96a8e124f31c1076d7ddc6268942ba504f6d60c4c82"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.16.0/boost-cli-linux-x64"
    sha256 "0fc83c70b5e41bffa8ff2e360c66ddc00efac32a93c6152302d79b9a3e55cded"
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
    assert_match "1.16.0", shell_output("#{bin}/boost-cli --version")
  end
end
