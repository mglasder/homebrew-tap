class Normen < Formula
  desc "Vim-style CLI to search and read German law from gesetze-im-internet.de"
  homepage "https://github.com/mglasder/normen"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mglasder/normen/releases/download/v0.2.0/normen-aarch64-apple-darwin.tar.xz"
      sha256 "74671f04376f623a5720cbf1bf302c072c50e58e96fc717c308ba50a77e53a4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mglasder/normen/releases/download/v0.2.0/normen-x86_64-apple-darwin.tar.xz"
      sha256 "3d31169e0fa8d86fc46017f812e0142254264ec39b98e9514bd4400f0511eb6f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mglasder/normen/releases/download/v0.2.0/normen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d54112ac7e1a970f000412b954f8fd772c0e176473b45e18ad913f9e787c380f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mglasder/normen/releases/download/v0.2.0/normen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0078103455adce62de6651d8cf5a234741e4895317f495ed0bfe9798761c940"
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
