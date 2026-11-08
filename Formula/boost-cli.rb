class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.42.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.42.0/boost-cli-macos-arm64"
      sha256 "e12e7bcc54d642d1acfbbf6fb147980694887fd61664329a2c9ef0f359a35a08"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.42.0/boost-cli-macos-x64"
      sha256 "08f2fa0f33bc7bc69233401ff868e37f2ed46b689137c487352f7f21d8b37f3c"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.42.0/boost-cli-linux-x64"
    sha256 "0047c7b5d77f5a0a5b1c7a8054c102efc9260f83a4c6ff2140dbd28daf9c1e88"
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
    assert_match "1.42.0", shell_output("#{bin}/boost-cli --version")
  end
end
