class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-sync-cli"
  version "1.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.1/boost-cli-macos-arm64"
      sha256 "176e391002ec496059fd2c17230095bc2d084f7a431bbdcc666a653f2557455b"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.1/boost-cli-macos-x64"
      sha256 "f898dcba740e763393afc46e29f2736777eafd14b1947befa6835633fa1e86a3"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.1/boost-cli-linux-x64"
    sha256 "80abe2337305b4fa35804b38aa37649a2168e41efc41b313ffc8ae4a04392e26"
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
    system "#{bin}/boost-cli", "--version"
  end
end
