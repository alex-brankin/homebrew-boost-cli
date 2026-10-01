class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.22.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.22.0/boost-cli-macos-arm64"
      sha256 "f6d5cc5a45fccae2a4ba253e869fe7c0c4ac6b7cea67d05444b5294340226b99"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.22.0/boost-cli-macos-x64"
      sha256 "cf2cab64c22b63e8e41ea78fedd07bf0f7e1757c2efc0f3424389c566ae3fa1a"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.22.0/boost-cli-linux-x64"
    sha256 "405750e87dd8ceb98bc9be335b359c2e3c482567cd721ab36ce8730730243ac9"
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
    assert_match "1.22.0", shell_output("#{bin}/boost-cli --version")
  end
end
