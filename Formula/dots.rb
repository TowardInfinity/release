class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.4.6"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.6/dots_darwin_arm64"
    sha256 "acafb869061de4724c84658938df9ecb6135837ede187c680b6768825a9f20e9"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.6/dotsd_darwin_arm64"
      sha256 "7cb6446ccd334f66a9e1a220a8a27ff5407fcb41a1e9d73175dbd313acdc32e6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.6/dots_linux_arm64"
      sha256 "569bf15787ac93589b8e859fd57dce8e29138c4630cd2381b7bf23d94efc8be5"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.6/dotsd_linux_arm64"
        sha256 "c87e7c67da7dac6be5e62f2f32928f92da6217d2f0e5aa51cf1b1be3759ca20e"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.6/dots_linux_amd64"
      sha256 "d8489a5e5908a5fdbcbbb147c1eae708734da722a48ee9deff96ca4c7b1afa56"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.6/dotsd_linux_amd64"
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
