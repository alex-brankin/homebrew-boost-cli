class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-sync-cli"
  version "1.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.2/boost-cli-macos-arm64"
      sha256 "315cd339c4da8fdd996b34682eed9e59a8537f9c752c650d94baec933a60b93f"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.2/boost-cli-macos-x64"
      sha256 "c3cc44be6ec753c83aeedec84b7ff7c3e7035608e59a18878079d7a9e6ad6777"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/raw/main/releases/v1.0.2/boost-cli-linux-x64"
    sha256 "67c986889421bb4b20c0ede744c85fb1693e972285e3d304a60b55d65d30a3ae"
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
