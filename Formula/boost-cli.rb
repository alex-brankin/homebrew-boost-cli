class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.17.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.11/boost-cli-macos-arm64"
      sha256 "29f52af2a05f4cd285c3d7977bf1c8ae74b8abb0a096a6ede88e5a526be23ec7"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.11/boost-cli-macos-x64"
      sha256 "9b449ccc6e4b440614fe2356527ca1d4aebb7b76f5dc94f2ba719b5b892b4393"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.17.11/boost-cli-linux-x64"
    sha256 "2751e007f6567eded4f8d1383fc47e48ea52dd69da4e0fa4d8ff2f3a224c7e96"
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
    assert_match "1.17.11", shell_output("#{bin}/boost-cli --version")
  end
end
