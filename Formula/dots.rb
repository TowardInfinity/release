class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.3.0"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.3.0/dots_darwin_arm64"
    sha256 "6bb6cc9c1cdf1824a27320e9e6bcfe5ecd85467be8f3ca7958759a90a0694985"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.3.0/dotsd_darwin_arm64"
      sha256 "ad2ebde505dc08bebe41d06b63a13d44785d3426bc04abe0959808f83625c538"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.3.0/dots_linux_arm64"
      sha256 "84368ff778389ef9ad816fc1abe3fa21d01cd9cd104f64c8dc3b52b3939dc1b0"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.3.0/dotsd_linux_arm64"
        sha256 "7309dec2780f751ec357a06c749ad31be61a776aaf8d02f3badc75c9d8656658"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.3.0/dots_linux_amd64"
      sha256 "d3f3831bf7d360a225b9ce8f16af26ce19fc0c943fe79dff7cb355d822d5938b"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.3.0/dotsd_linux_amd64"
        sha256 "8c5994670d92c9f23946447399b13521bc3e88657070f504a7fcd952d0251964"
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
