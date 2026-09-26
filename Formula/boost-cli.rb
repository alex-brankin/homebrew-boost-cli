class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.7/boost-cli-macos-arm64"
      sha256 "94892ce4f3e20344f83becbe2546318ac6075ca14cc7f74231335fe9a5b9d0f4"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.7/boost-cli-macos-x64"
      sha256 "0feb867ea5b7845cbb28ef450c214e82e1c52ad41779e6c909fd7664eec69c67"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.7/boost-cli-linux-x64"
    sha256 "ebda1d1863493b65a09a99ffa2b37de242191e1d7a1fff779bc9eb8b0077710c"
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
    assert_match "1.17.7", shell_output("#{bin}/boost-cli --version")
  end
end
