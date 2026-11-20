class Dots < Formula
  desc "Portable dev environment manager"
  homepage "https://github.com/TowardInfinity/release"
  version "0.4.4"
  # Assets are the bare signed binaries of the dots-vX.Y.Z mirror release, not
  # archives; shas come from that release's signed checksums.txt. A bump moves
  # the version and all six url+sha lines in the same commit.
  # macOS ships arm64 only; Linux ships arm64 and amd64. The url sits directly
  # in on_macos (not a nested on_arm) so Intel Macs still resolve a URL at tap
  # time and are stopped by the arch guard instead.
  on_macos do
    depends_on arch: :arm64

    url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.4/dots_darwin_arm64"
    sha256 "122b1bc69993ef00d44a8a200faf232a1780aa51749a311e1095fab69e00d249"

    resource "dotsd" do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.4/dotsd_darwin_arm64"
      sha256 "77f7bb7bc56d620e151fccb830a10ff6a4e2c4a0aa3027b44acf19ef7a1e9e3c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.4/dots_linux_arm64"
      sha256 "5d5b7f4d437b9ed19ffa431aff267fc11ce7bba061053c59e37c5c8da13e9c6f"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.4/dotsd_linux_arm64"
        sha256 "02ea2692980a7f7b091af37084ac3dfe68572c4bbaed7d5b551de5169fdcb547"
      end
    end
    on_intel do
      url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.4/dots_linux_amd64"
      sha256 "9a347f00843200e1716d8ff2aafcfc746d09212a39d7cca138f7922d66e6df87"

      resource "dotsd" do
        url "https://github.com/TowardInfinity/release/releases/download/dots-v0.4.4/dotsd_linux_amd64"
        sha256 "f3b8424996cbea07095e734a73bd8bf96b502cf8396920fa1c3f78072331795a"
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
