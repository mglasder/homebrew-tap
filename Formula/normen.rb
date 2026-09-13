class Normen < Formula
  desc "Vim-style CLI to search and read German law from gesetze-im-internet.de"
  homepage "https://github.com/mglasder/normen"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mglasder/normen/releases/download/v0.1.0/normen-aarch64-apple-darwin.tar.xz"
      sha256 "85f23672bedf7f4aeb6a9de7782c012f135d799d421acb914261d9869633ae05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mglasder/normen/releases/download/v0.1.0/normen-x86_64-apple-darwin.tar.xz"
      sha256 "9acfbb3ab5a2bf57d8a9bd19f0e7e6d7c508005bca35f37303bc5fa9a323cc3b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mglasder/normen/releases/download/v0.1.0/normen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2c17bc9b113eb602ccdc92bac17f7de95cc6c025d985abed2a78fb8c943cc7ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mglasder/normen/releases/download/v0.1.0/normen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e80ff8c16383e728907298b608a52bbf0593e837efa322e9e860da4e37320d99"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "normen"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "normen"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "normen"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "normen"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
