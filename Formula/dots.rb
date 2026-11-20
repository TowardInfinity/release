class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.4.5"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.5/dots_darwin_arm64"
    sha256 "3e49f6704936404c0a1c2ef5d943ec2db1ac69181b35df5f60066778f1cecdc5"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.5/dotsd_darwin_arm64"
      sha256 "7cb6446ccd334f66a9e1a220a8a27ff5407fcb41a1e9d73175dbd313acdc32e6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.5/dots_linux_arm64"
      sha256 "94fb2f30f41170ff9478ab50e237367d4d82ada1e5b58488bdaa20b6e239c975"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.5/dotsd_linux_arm64"
        sha256 "c87e7c67da7dac6be5e62f2f32928f92da6217d2f0e5aa51cf1b1be3759ca20e"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.5/dots_linux_amd64"
      sha256 "bb42fe5dfb7293681322cb07645ed0d825a3a11980acc96434ae7e16603df492"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.5/dotsd_linux_amd64"
        sha256 "3d6cfc302e07bb0c71e65b78eda25f0d283234a00bcfbc5a6987f5a0d998f535"
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
