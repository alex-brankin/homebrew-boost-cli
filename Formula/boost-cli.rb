class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.40.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.40.0/boost-cli-macos-arm64"
      sha256 "fdab87e26e3c225563aa23fe55a9ee817cf8eae8e90df1b708e1ef269d0227b5"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.40.0/boost-cli-macos-x64"
      sha256 "bd18512479f7a79e68fdfe9592e1fc5a91f9782cac8397123916066e886d65c1"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.40.0/boost-cli-linux-x64"
    sha256 "3ea62edcbe28bd33f65919331f8b118ba432033aea13e58b4d873b7778f5392f"
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
    assert_match "1.40.0", shell_output("#{bin}/boost-cli --version")
  end
end
