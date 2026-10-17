class Anamn < Formula
  desc "Local-first AI-memory CLI"
  homepage "https://github.com/TowardInfinity/anamn"
  version "0.8.0"
  license "MIT"
  depends_on arch: :arm64
  # Mirror-tag revision note: URLs embed the dots-releases tag that carries
  # the assets (anamn-v0.8.0-1). Any re-roll = new tag suffix + url+sha bump
  # in the same PR; shas below come from the release notes, not this file.
  # URLs are per-OS (not per-arch): v0.8.0 ships arm64 only, and
  # `depends_on arch: :arm64` above is the install-time guard for Intel.
  # (Nested on_arm blocks leave Intel variants URL-less, which fails
  # tap-time validation with "formula requires at least a URL".)
  on_macos do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.8.0-1/anamn-darwin-aarch64.tar.gz"
    sha256 "59d5d0d076e048f8151d514908e0861fc445cb17ce3525ee7fdd2ee9034a9c19"
  end
  on_linux do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.8.0-1/anamn-linux-aarch64.tar.gz"
    sha256 "312be2fe7329fb08a68d0b90a6bd9f6acc2065c6ef83e1c8c7a9d010d6692733"
  end

  def install
    bin.install "anamn"
  end

  test do
    assert_match "anamn", shell_output("#{bin}/anamn --version")
  end
end
