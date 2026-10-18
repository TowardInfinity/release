class Anamn < Formula
  desc "Local-first AI-memory CLI"
  homepage "https://github.com/TowardInfinity/anamn"
  version "0.10.1"
  license "MIT"
  depends_on arch: :arm64
  # Mirror-tag revision note: URLs embed the dots-releases tag that carries
  # the assets (anamn-v0.10.1-1). Any re-roll = new tag suffix + url+sha bump
  # in the same PR; shas below come from the release notes, not this file.
  # URLs are per-OS (not per-arch): v0.10.1 ships arm64 only, and
  # `depends_on arch: :arm64` above is the install-time guard for Intel.
  # (Nested on_arm blocks leave Intel variants URL-less, which fails
  # tap-time validation with "formula requires at least a URL".)
  on_macos do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.10.1-1/anamn-darwin-aarch64.tar.gz"
    sha256 "653e2b99971d7a50a1a0957933c90ca09df0b47b36342c2e10d72710f58246ea"
  end
  on_linux do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.10.1-1/anamn-linux-aarch64.tar.gz"
    sha256 "2c88a19061fdbd883efd186d7fabe17571b21f715a6ce0465ce478e544acf0db"
  end

  def install
    bin.install "anamn"
  end

  test do
    assert_match "anamn", shell_output("#{bin}/anamn --version")
  end
end
