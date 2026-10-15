class BoostCli < Formula
  desc "CLI tool for syncing Boost Commerce templates with your local development environment"
  homepage "https://github.com/alex-brankin/homebrew-boost-cli"
  version "1.36.0"
  license "ISC"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.36.0/boost-cli-macos-arm64"
      sha256 "d13b5805c78fe40bce70bfbe9a2fccba043bee7a00e761e0faf94ef441387c56"
    else
      url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.36.0/boost-cli-macos-x64"
      sha256 "83ade4e1c9f12140a102a3810e520dfd6591f1c81665ce4c4eb651314b02c3b3"
    end
  end

  on_linux do
    url "https://github.com/alex-brankin/homebrew-boost-cli/releases/download/v1.36.0/boost-cli-linux-x64"
    sha256 "46e4449df65d07e7540af7ce14e28e77860589b9090aeb51f428b43b19c4e649"
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
    assert_match "1.36.0", shell_output("#{bin}/boost-cli --version")
  end
end
