class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.4.0"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.0/dots_darwin_arm64"
    sha256 "d8e392826cd318334237af67e076f7e358da360ca9ca301cbdd86fef9b5ac454"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.0/dotsd_darwin_arm64"
      sha256 "ecbc6d6a5483562e661af556e39feb8fcf9f8c63c4337cfaaa90ea6f395e96a9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.0/dots_linux_arm64"
      sha256 "bafe3bc216214b0428d4f988e30e0d0b79205c76263a605fdbda139c49fd053f"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.0/dotsd_linux_arm64"
        sha256 "5293f74af353943ae4ba2745b00f8c9e9d478426ca7a311e80ab532edf64a4b7"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.0/dots_linux_amd64"
      sha256 "bb96e1bd7bae88cf48c42951cb65ffd8b57631a32a07d18c1d3b743217131b38"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.0/dotsd_linux_amd64"
        sha256 "4bf7cda925067db946e23221e21b37390a5ff21d6f0c128434192c44121b4cdd"
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
