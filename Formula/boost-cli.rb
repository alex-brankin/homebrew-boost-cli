class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.43.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.43.0/boost-cli-macos-arm64"
      sha256 "fd21c5ebcc28ccf494ba1f045ea3248fe9db263ce9bcb54a63717720282308c0"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.43.0/boost-cli-macos-x64"
      sha256 "5ec832a69b6e0363cabf32c36bb2dc6db0caf9e9307c7717079e5f65830e792d"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.43.0/boost-cli-linux-x64"
    sha256 "a38999a77efad00c487d33237a693576f965b8327cf0b1abfe687310fad958fa"
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
    assert_match "1.43.0", shell_output("#{bin}/boost-cli --version")
  end
end
