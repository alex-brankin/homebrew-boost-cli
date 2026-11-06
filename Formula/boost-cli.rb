class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.41.2"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.2/boost-cli-macos-arm64"
      sha256 "a6411b4cbc91c3e8739dc2aab418ead2d3506cd7091a486090c82e3ed1d36862"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.2/boost-cli-macos-x64"
      sha256 "8bbe4db457ebfc72af23437c8090495763a698d351e6a927e72fbcddcab00be2"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.41.2/boost-cli-linux-x64"
    sha256 "93ee7d5e64bc4d244e2b5a404d128f4942e625be65395a774663ba07f7cb20e4"
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
    assert_match "1.41.2", shell_output("#{bin}/boost-cli --version")
  end
end
