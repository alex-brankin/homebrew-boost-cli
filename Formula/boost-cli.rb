class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.37.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.37.0/boost-cli-macos-arm64"
      sha256 "9496fd4343f9d88ec2c5a643dfa39d676d67cf6b8a14851d67b951ccc00778fc"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.37.0/boost-cli-macos-x64"
      sha256 "6aee9b5678e771da2428318d85af816daacceb123fb03f32a55f476b0be0471b"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.37.0/boost-cli-linux-x64"
    sha256 "810e7dd0dc5d9110f3aa7b40c66d910f7a9871b76ed187d12b94559253ceb578"
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

  def caveats
    <<~EOS
      boost-cli is licensed by invitation. To use it, email alex@clearer.io
      and say what you would use it for.

      What it does:
        - Edit Boost templates in your own editor; push, verify, roll back safely
        - See what shoppers see: the grid, filters, the search box, recommendations
        - Tune search - synonyms, redirects, weights - and find why a product ranks
        - Write and prove merchandising rules and recommendation widgets
        - Copy one store's Boost set-up to others, and diff stores side by side
        - Every store change journalled, listed and undoable; works with AI agents

      boost-cli doctor and boost-cli start run without a licence.
    EOS
  end

  test do
    assert_match "1.37.0", shell_output("#{bin}/boost-cli --version")
  end
end
