class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.24.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.24.0/boost-cli-macos-arm64"
      sha256 "df397e0eac3ee4d71cbaffe5c402601021a17522005f560d03bf43445f6ccb6f"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.24.0/boost-cli-macos-x64"
      sha256 "554a005a6f6953da37e9e9bbe3d969632df5a61596d3df19cdd5eb02008eb5b8"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.24.0/boost-cli-linux-x64"
    sha256 "afb5abf55a5e078da3a366ea39749ac0f7f44633810ecc39e6705e52a841a1c2"
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
    assert_match "1.24.0", shell_output("#{bin}/boost-cli --version")
  end
end
