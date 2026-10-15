class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.35.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.35.0/boost-cli-macos-arm64"
      sha256 "23d1d5ee165a034baa03575d678db00d4675e3a263be7a55fd70fd7d5bed4990"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.35.0/boost-cli-macos-x64"
      sha256 "bdab1536be5ab785d4a3b48ad297ddab0d73a62a03538d0a01a6336c75daa2d8"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.35.0/boost-cli-linux-x64"
    sha256 "93d9369f12b91a697dc1e3e40a20b4d3b55e88b15d4748051b6244374a2296be"
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
    assert_match "1.35.0", shell_output("#{bin}/boost-cli --version")
  end
end
