class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.44.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.44.0/boost-cli-macos-arm64"
      sha256 "787117fcc4021c58b0fb4a6717b07cae902e85ef1e375ef7d925cece55371a75"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.44.0/boost-cli-macos-x64"
      sha256 "dc2e579a272ae4f8f0bf4a1d1a629efc3b5e7fd03115f493a70e7591c2679bc0"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.44.0/boost-cli-linux-x64"
    sha256 "298092f5891603111f836d24b55b499b57d67fecb19e1b2accbefd20f23e9cbe"
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
    assert_match "1.44.0", shell_output("#{bin}/boost-cli --version")
  end
end
