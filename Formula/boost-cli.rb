class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.10/boost-cli-macos-arm64"
      sha256 "0d0ba38e45a4206858d78cc851f4b71b842c411e26a3705f37631edbaf1a8e84"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.10/boost-cli-macos-x64"
      sha256 "9b5b69275bfd92882e4eb6d3ac1222b5efe762a6d42b0f65f17ab5050e524b69"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.10/boost-cli-linux-x64"
    sha256 "5a434d3cd9c83ccf24edb99288e9baafe5379e750f81a9ba7abb49004d62b8ce"
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
    assert_match "1.17.10", shell_output("#{bin}/boost-cli --version")
  end
end
