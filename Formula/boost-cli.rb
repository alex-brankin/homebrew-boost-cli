class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.38.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.38.0/boost-cli-macos-arm64"
      sha256 "09fd3a06fab2cdccb7c6bb209964c3fca9595049a86d22769a581ef64e77b8ba"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.38.0/boost-cli-macos-x64"
      sha256 "4c813fe0471f12f6456df000c0cf5cc71c07505a1bf5aab46fc2762e87477bce"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.38.0/boost-cli-linux-x64"
    sha256 "1675ebbedbf36edb00135aa9ca67dc3b81ca7645db87e8ae31193d179ed4b823"
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
    assert_match "1.38.0", shell_output("#{bin}/boost-cli --version")
  end
end
