class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.4.1"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.1/dots_darwin_arm64"
    sha256 "8706c42cb64de1ea398ab99fb3c8093a567d52796a2e5522bd946a6ef1af883f"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.1/dotsd_darwin_arm64"
      sha256 "ecbc6d6a5483562e661af556e39feb8fcf9f8c63c4337cfaaa90ea6f395e96a9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.1/dots_linux_arm64"
      sha256 "7db7bf07b84200f8cf7204e1359ad26af8051be17262b1957eda8c7de87ed8d9"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.1/dotsd_linux_arm64"
        sha256 "5293f74af353943ae4ba2745b00f8c9e9d478426ca7a311e80ab532edf64a4b7"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.1/dots_linux_amd64"
      sha256 "62dd92dd36580b31cfb790a3173b94b3dd83e7108e550dbdd12661e1eb6f4b77"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.1/dotsd_linux_amd64"
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
