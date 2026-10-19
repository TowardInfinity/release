class Anamn < Formula
  desc "Local-first AI-memory CLI"
  homepage "https://github.com/TowardInfinity/anamn"
  version "0.11.0"
  license "MIT"
  depends_on arch: :arm64
  # Mirror-tag revision note: URLs embed the dots-releases tag that carries
  # the assets (anamn-v0.11.0-1). Any re-roll = new tag suffix + url+sha bump
  # in the same PR; shas below come from the release notes, not this file.
  # URLs are per-OS (not per-arch): v0.11.0 ships arm64 only, and
  # `depends_on arch: :arm64` above is the install-time guard for Intel.
  # (Nested on_arm blocks leave Intel variants URL-less, which fails
  # tap-time validation with "formula requires at least a URL".)
  on_macos do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.11.0-1/anamn-darwin-aarch64.tar.gz"
    sha256 "a67c67fc2602c80a3128bf0d1381c2538ab6dcef3b86077596b79a6a496c2b7c"
  end
  on_linux do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.11.0-1/anamn-linux-aarch64.tar.gz"
    sha256 "ce7896f80b90e94392639f32abbfafb3048ca19c6e53288dcd626dd451bd1b53"
  end

  def install
    bin.install "anamn"
  end

  test do
    assert_match "anamn", shell_output("#{bin}/anamn --version")
  end
end
