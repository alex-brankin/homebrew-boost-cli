class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.39.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.39.0/boost-cli-macos-arm64"
      sha256 "576f8d5bf3cfc68face36d897974a5f7294340ea814c93f8c989d3138d70b655"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.39.0/boost-cli-macos-x64"
      sha256 "c6929434e76919ea504cf28216de6b8d84b49c5641f5c0442d762b03d5c3f43d"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.39.0/boost-cli-linux-x64"
    sha256 "84ee95960fd4b2b8180817ba1ba7362f3530aa25ae748e276183df88560708fe"
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
    assert_match "1.39.0", shell_output("#{bin}/boost-cli --version")
  end
end
