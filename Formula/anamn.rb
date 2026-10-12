class Anamn < Formula
  desc "Local-first AI-memory CLI"
  homepage "https://github.com/TowardInfinity/anamn"
  version "0.6.0"
  license "MIT"
  depends_on arch: :arm64
  # Mirror-tag revision note: URLs embed the dots-releases tag that carries
  # the assets (anamn-v0.6.0-1). Any re-roll = new tag suffix + url+sha bump
  # in the same PR; shas below come from the release notes, not this file.
  # URLs are per-OS (not per-arch): v0.6.0 ships arm64 only, and
  # `depends_on arch: :arm64` above is the install-time guard for Intel.
  # (Nested on_arm blocks leave Intel variants URL-less, which fails
  # tap-time validation with "formula requires at least a URL".)
  on_macos do
    url "https://github.com/TowardInfinity/dots-releases/releases/download/anamn-v0.6.0-1/anamn-darwin-aarch64.tar.gz"
    sha256 "87c0ffcf80c6b3025baaa11b4977f2f4c2dfac0a7ef3d839c95c6e975a6bf2f8"
  end
  on_linux do
    url "https://github.com/TowardInfinity/dots-releases/releases/download/anamn-v0.6.0-1/anamn-linux-aarch64.tar.gz"
    sha256 "f258f121b211394eab2f777965a472ad7ac3616648744be00be90efaad8449b6"
  end

  def install
    bin.install "anamn"
  end

  test do
    assert_match "anamn", shell_output("#{bin}/anamn --version")
  end
end
