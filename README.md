# Release mirror for signed releases

Public mirror for the signed release artifacts of this account's products:
`dots` today, `anamn` from `anamn-v0.7.0-1`. Mirror-only: Release objects,
assets, `Formula/`. No build or sign workflow lives here.

## Trust

One Ed25519 key per product:

| Key | Product |
| --- | --- |
| `keys/release.pub` | dots |
| `keys/anamn.pub` | anamn |

Fingerprint of a key:

```sh
openssl pkey -pubin -in keys/release.pub -outform DER \
  | openssl dgst -sha256 -binary | base64
```

## dots

Tags `dots-vX.Y.Z`. Bare `vX` is the Go era and stays on `dots-releases`.

### Layout per tag

`dots_darwin_arm64`, `dots_linux_arm64`, `dots_linux_amd64`, same three
`dotsd_*`, `dots-config.tar.gz`, `bootstrap-release.sh`, `dots.sh`,
`checksums.txt` + `.sig`, `release.json` + `.sig`. No `darwin_amd64` leg is
built.

### Homebrew

```sh
brew tap TowardInfinity/release https://github.com/TowardInfinity/release
brew install dots
```

`Formula/dots.rb` installs the `dots` and `dotsd` binaries of the tag it names
(macOS arm64, Linux arm64 and amd64), pinned by the shas in that tag's signed
`checksums.txt`. It installs the binaries only; the config bundle and launcher
still come from `dots.sh`.

## anamn

Tags `anamn-vX.Y.Z-N`. Everything released up to `anamn-v0.6.0-1` stays on
`TowardInfinity/dots-releases`.

### Layout per tag

`anamn-darwin-aarch64.tar.gz`, `anamn-darwin-x86_64.tar.gz`,
`anamn-linux-aarch64.tar.gz`, `anamn-linux-x86_64.tar.gz`,
`anamn-windows-x86_64.zip`, `anamn-sha256sums.txt` + `.sig`, `install.sh`.

### Verification

The signed manifest lists the five archives **and `install.sh`** — the file that
carries the pinned release key — so one signature covers the installer too, and
`release.sh publish` refuses to un-draft a release whose attached installer does
not match the sum the manifest names. `install.sh` embeds the same public key as
`keys/anamn.pub`; the source repo keeps its own copy at `keys/release.pub` and a
compiled-in copy at `crates/anamn/keys/release.pub` for `anamn update`.

Check a downloaded installer before running it:

```sh
curl -fsSLO https://github.com/TowardInfinity/release/releases/download/anamn-vX.Y.Z-N/install.sh
curl -fsSLO https://github.com/TowardInfinity/release/releases/download/anamn-vX.Y.Z-N/anamn-sha256sums.txt
curl -fsSLO https://github.com/TowardInfinity/release/releases/download/anamn-vX.Y.Z-N/anamn-sha256sums.txt.sig
openssl pkeyutl -verify -pubin -inkey keys/anamn.pub \
  -sigfile anamn-sha256sums.txt.sig -in anamn-sha256sums.txt -rawin
sha256sum install.sh      # macOS: shasum -a 256 install.sh
# the result must equal the "install.sh" line of that verified manifest
```

Fingerprint of `keys/anamn.pub`:

```
DR2VoNQOaiUoBz4xFwHeAncoHjZQn0g/RWIF4gdb1HM=
```
