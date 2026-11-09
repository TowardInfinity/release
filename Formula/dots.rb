class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.4.2"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.2/dots_darwin_arm64"
    sha256 "d6d0597db7f6c36765c7de0b76c5bbfff0c3815ab211a3a40c4603348ad75696"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.2/dotsd_darwin_arm64"
      sha256 "ecec6c178d356f6661c0ea8d05ea5145a9224aebad0936265ab20886821ec0e6"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.2/dots_linux_arm64"
      sha256 "fed162f8f548eccca6eb5c00227a649994aa3a80579b85fff32fbbcf460f7d4a"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.2/dotsd_linux_arm64"
        sha256 "5293f74af353943ae4ba2745b00f8c9e9d478426ca7a311e80ab532edf64a4b7"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.2/dots_linux_amd64"
      sha256 "5ed32061f214f162af6ac0bbb104afd78f2bce0ff63b763f298d3a54b68425b2"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.2/dotsd_linux_amd64"
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
