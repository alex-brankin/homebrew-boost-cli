class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.34.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.34.0/boost-cli-macos-arm64"
      sha256 "3a58d644761247283633d7408a9bf09f76157e452f3973f02e1b1f4cd25d353a"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.34.0/boost-cli-macos-x64"
      sha256 "a71081ab1bcf6e1334aac70fc54069a7a832b3c6921fcc9be7852d46977a406b"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.34.0/boost-cli-linux-x64"
    sha256 "8a557f9b80b51697b5c9c5ee2768ed6f889f514faedf392f61ce5265a927d4e2"
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
    assert_match "1.34.0", shell_output("#{bin}/boost-cli --version")
  end
end
