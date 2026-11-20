class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.4.3"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.3/dots_darwin_arm64"
    sha256 "5aff65ed127ea0ddd3a7c91df421b306eb995af944584ce96fbb0358a476e328"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.3/dotsd_darwin_arm64"
      sha256 "32138706f35ffe3e1bbddee623255bb2b5ec04a98ef5c68320cf761c2bd4420f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.3/dots_linux_arm64"
      sha256 "e18f59ea751d2aef520958b84209908befdb807c70c521f2f763cdbd7c9d0114"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.3/dotsd_linux_arm64"
        sha256 "b193a44fea4b39bf450a887bef38900797749fff6fb9e7be09c1dc3df13b7b9c"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.3/dots_linux_amd64"
      sha256 "d95183fdccbb4c9e32e623d213e145eae4a5a6b760a731907cc4150f2f97164a"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.3/dotsd_linux_amd64"
        sha256 "ce54695033f17f383e15c21f81ab7f715ddfc3ed47768641bebf9579d8edcedc"
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
