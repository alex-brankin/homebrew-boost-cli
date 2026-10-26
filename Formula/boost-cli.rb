class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.41.1"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.1/boost-cli-macos-arm64"
      sha256 "f54e5b4313b677f081c4f07e5cd855877fb624ac979505c6aa77f4c3595ac09b"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.1/boost-cli-macos-x64"
      sha256 "00a18f8a54b35cc955843752bba708fd1b0c0eead7da65b7dce5ca1e68d73a63"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.1/boost-cli-linux-x64"
    sha256 "109418b6d5f07d2616c1e1304fcd48bac340c3df5ecd0689c277dcf58dbe8585"
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
    assert_match "1.41.1", shell_output("#{bin}/boost-cli --version")
  end
end
