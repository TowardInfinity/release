class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.5.0"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.0/dots_darwin_arm64"
    sha256 "c98e88423ee0464a73932a73e58eb1920b4dcc6c703fec7353134eb16de32a30"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.0/dotsd_darwin_arm64"
      sha256 "e5f10e663a37c201958b9a04ab34e5cada50f3c83db4b20f4c58aa7b4519eeef"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.0/dots_linux_arm64"
      sha256 "3c25c1ba3d38ff1655d491007298f101965e2b35abacc962d189b887be37b5f6"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.0/dotsd_linux_arm64"
        sha256 "cee55582c61309962d86f141e2898c886bf3a3330d8d6d54a07741c6578db97e"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.0/dots_linux_amd64"
      sha256 "d679b065c29fb1e1639f7cbf68a3f864a1433686d5534d61fb158449f03c13bd"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.5.0/dotsd_linux_amd64"
        sha256 "4128512902c8c9766192302f372dde194005849b326e2d4fe3a7140f6b5e4240"
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
