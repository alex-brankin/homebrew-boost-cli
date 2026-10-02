class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.30.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.30.0/boost-cli-macos-arm64"
      sha256 "3cfd4f34c5168d8f5c32a7452b1dfb53e849ceeef9def9eb99a98dccc8e2a6a2"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.30.0/boost-cli-macos-x64"
      sha256 "999af2d512fb6b9699666a536be8a1f3a98f2394e552808515fd223174150e6e"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.30.0/boost-cli-linux-x64"
    sha256 "f1b4e4efd3319fd10d2b80f28c6e9944137ed8947dad269c7c426a9b11c9c4ad"
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
    assert_match "1.30.0", shell_output("#{bin}/boost-cli --version")
  end
end
