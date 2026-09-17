class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.6.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.6.1/boost-cli-macos-arm64"
      sha256 "493820f039da11b646c0006ac755fbbc2f1d6c6aa87fb94b993a91cd9a73bf1c"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.6.1/boost-cli-macos-x64"
      sha256 "506914c344e6fd618321a011ca7306d08698c6e5185d20517cee4dff8a61a9fa"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.6.1/boost-cli-linux-x64"
    sha256 "c39db29be7d120fb82ab136182ab7e1432bc3300cf09bfaaa409151eb4de692f"
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
    assert_match "1.6.1", shell_output("#{bin}/boost-cli --version")
  end
end
