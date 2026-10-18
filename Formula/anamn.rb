class Anamn < Formula
  desc "Local-first AI-memory CLI"
  homepage "https://github.com/TowardInfinity/anamn"
  version "0.10.0"
  license "MIT"
  depends_on arch: :arm64
  # Mirror-tag revision note: URLs embed the dots-releases tag that carries
  # the assets (anamn-v0.10.0-1). Any re-roll = new tag suffix + url+sha bump
  # in the same PR; shas below come from the release notes, not this file.
  # URLs are per-OS (not per-arch): v0.10.0 ships arm64 only, and
  # `depends_on arch: :arm64` above is the install-time guard for Intel.
  # (Nested on_arm blocks leave Intel variants URL-less, which fails
  # tap-time validation with "formula requires at least a URL".)
  on_macos do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.10.0-1/anamn-darwin-aarch64.tar.gz"
    sha256 "5e30439835ba26a893a6447b698e9a85233e3eefea6063e7432045815e01d7b5"
  end
  on_linux do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.10.0-1/anamn-linux-aarch64.tar.gz"
    sha256 "5ca339e3a7af01fd6ea1021dac612e87103dd5a7fbe4c686a98cb165dec421b6"
  end

  def install
    bin.install "anamn"
  end

  test do
    assert_match "anamn", shell_output("#{bin}/anamn --version")
  end
end
