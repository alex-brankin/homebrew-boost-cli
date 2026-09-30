class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.19.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.19.0/boost-cli-macos-arm64"
      sha256 "cd2348c1dff3c966323991ffd8bc73d0d758e1d58e844abeff4fd2f1cb1cbf7f"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.19.0/boost-cli-macos-x64"
      sha256 "4e76475003555dc2490ad72fea72fc1b9f70363cbcee7afa6659fa57609bb91a"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.19.0/boost-cli-linux-x64"
    sha256 "453f28acd7a4c1a2355b5e437a78064bfa9047140c574d1e3a095b1bcc273cdc"
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
    assert_match "1.19.0", shell_output("#{bin}/boost-cli --version")
  end
end
