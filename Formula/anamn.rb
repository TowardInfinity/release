class Anamn < Formula
  desc "Local-first AI-memory CLI"
  homepage "https://github.com/TowardInfinity/anamn"
  version "0.12.1"
  license "MIT"
  depends_on arch: :arm64
  # Mirror-tag revision note: URLs embed the dots-releases tag that carries
  # the assets (anamn-v0.12.1-1). Any re-roll = new tag suffix + url+sha bump
  # in the same PR; shas below come from the release notes, not this file.
  # URLs are per-OS (not per-arch): v0.12.1 ships arm64 only, and
  # `depends_on arch: :arm64` above is the install-time guard for Intel.
  # (Nested on_arm blocks leave Intel variants URL-less, which fails
  # tap-time validation with "formula requires at least a URL".)
  on_macos do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.12.1-1/anamn-darwin-aarch64.tar.gz"
    sha256 "8f708e839b39760545b7f0f68acdfd2259531b0767f92f4b943e383cf644d74c"
  end
  on_linux do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.12.1-1/anamn-linux-aarch64.tar.gz"
    sha256 "715a0174d8bd01ac75dcfced8ded9ab98b557768edf86ccc1736c244656a2c40"
  end

  def install
    bin.install "anamn"
  end

  test do
    assert_match "anamn", shell_output("#{bin}/anamn --version")
  end
end
