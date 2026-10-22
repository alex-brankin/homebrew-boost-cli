class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.41.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.0/boost-cli-macos-arm64"
      sha256 "1599eef625e64957069804fafc124fc75da047942885647ad3f159dc6eb09502"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.0/boost-cli-macos-x64"
      sha256 "28ef0b623e33621cd38a5901689f63da719c6807d752fccf6fe96eb628ff0de2"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.0/boost-cli-linux-x64"
    sha256 "2a11c53fb73d6cbd4680041df8ed5d45777b382328849f6a959b9ec6f0cd2da5"
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
    assert_match "1.41.0", shell_output("#{bin}/boost-cli --version")
  end
end
