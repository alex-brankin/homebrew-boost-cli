class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/boost-cli"
  version "1.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.15.0/boost-cli-macos-arm64"
      sha256 "e0b3062ea4adab1ab6a1b6e8c09be9a73c4f13b4ee855e298799dbc09a161134"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.15.0/boost-cli-macos-x64"
      sha256 "625688666d2e5f792d6e88d40fd33e454101d171c6dee9440e89cef42d327487"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.15.0/boost-cli-linux-x64"
    sha256 "a8fdfc2d91d969527148557bc278cb064376235c2c5a52d916b8d797b7de3033"
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
    assert_match "1.15.0", shell_output("#{bin}/boost-cli --version")
  end
end
