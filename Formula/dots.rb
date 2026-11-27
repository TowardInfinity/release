class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.5.1"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.1/dots_darwin_arm64"
    sha256 "985f3ee145260a46e67674a549a0234b8b55edeacd4399bd81d567f006bef7d5"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.1/dotsd_darwin_arm64"
      sha256 "29197752e95be1f36d60c700121df2fd2beaeae36c22d9f83e8971e2533b3598"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.1/dots_linux_arm64"
      sha256 "5b8577b5a2f6d190d6b959f9fb8083fdd000b73d585db7fd86c6cf61bcb56880"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.1/dotsd_linux_arm64"
        sha256 "e684140f01d1c0bc2c04c63b4c763e2f4916cbd74cc38981ecd0c2d7c371a214"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.1/dots_linux_amd64"
      sha256 "68ebb3e02c36be373187140b9fbd0ca847ba5d41b738abd39ac572861ac71208"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.1/dotsd_linux_amd64"
        sha256 "876c6d6e2605c297fa4c8d12690dfdd9ef90b8a66f8a240ec32b39f111d37fe0"
      end
    end
  end

  def install
    bin.install File.basename(stable.url) => "dots"
    resource("dotsd").stage do
      bin.install File.basename(resource("dotsd").url) => "dotsd"
    end
  end

  test do
    assert_equal "dots-v#{version}", shell_output("#{bin}/dots version").strip
  end
end
