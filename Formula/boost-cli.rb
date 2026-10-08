class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.33.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.33.0/boost-cli-macos-arm64"
      sha256 "f389c4a06c15f66bb0ec0019eee818ebd33fbe125d6e46e8bf133559701665f8"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.33.0/boost-cli-macos-x64"
      sha256 "4a955675dd19e08c5a139bd64102e00171bb9723e20c39955eb156fa95c3d528"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.33.0/boost-cli-linux-x64"
    sha256 "eaf91170cb4d614cc1b14ad693dd388a13a3403e24def917ac2264720022f519"
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
    assert_match "1.33.0", shell_output("#{bin}/boost-cli --version")
  end
end
