class Anamn < Formula
  desc "Local-first AI-memory CLI"
  homepage "https://github.com/TowardInfinity/anamn"
  version "0.9.0"
  license "MIT"
  depends_on arch: :arm64
  # Mirror-tag revision note: URLs embed the dots-releases tag that carries
  # the assets (anamn-v0.9.0-1). Any re-roll = new tag suffix + url+sha bump
  # in the same PR; shas below come from the release notes, not this file.
  # URLs are per-OS (not per-arch): v0.9.0 ships arm64 only, and
  # `depends_on arch: :arm64` above is the install-time guard for Intel.
  # (Nested on_arm blocks leave Intel variants URL-less, which fails
  # tap-time validation with "formula requires at least a URL".)
  on_macos do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.9.0-1/anamn-darwin-aarch64.tar.gz"
    sha256 "474e4d3c6e8f7bb8fae92b8fae5413901688f9edeef5cefc605481a899aaf305"
  end
  on_linux do
    url "https://github.com/TowardInfinity/release/releases/download/anamn-v0.9.0-1/anamn-linux-aarch64.tar.gz"
    sha256 "f76ebfea6934c7bb70c48bde37a997eed23d2834f3532f204ab6caa016f93a79"
  end

  def install
    bin.install "anamn"
  end

  test do
    assert_match "anamn", shell_output("#{bin}/anamn --version")
  end
end
