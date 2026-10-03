class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.32.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.32.0/boost-cli-macos-arm64"
      sha256 "9f85f0804ec7daecc279b30e1459d9ee5372c16d3d6dd3776b595a40c1c395dd"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.32.0/boost-cli-macos-x64"
      sha256 "6b770c2bc28dd4fdcadaae8a99d44cdb6e64d41deb12d8d295dc4fe2417ad9be"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.32.0/boost-cli-linux-x64"
    sha256 "8c83d24606f71fd7a2120e123f3a4fe7d82f6a87ac058e78f4d317828c5319c8"
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
    assert_match "1.32.0", shell_output("#{bin}/boost-cli --version")
  end
end
