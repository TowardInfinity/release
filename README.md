# Release mirror for signed dots releases

Public mirror for `dots` (and later products). Mirror-only: Release
objects, assets, `Formula/`. No build or sign workflow lives here.

## Trust

`keys/release.pub` is the dots Rust release key. Fingerprint:

```
0D+9JC96B9Mv4gLWY1jh7ik0FpblBN+HTvqAxgS4HjM=
```

Verify:

```sh
openssl pkey -pubin -in keys/release.pub -outform DER \
  | openssl dgst -sha256 -binary | base64
```

## Tags

`dots-vX.Y.Z`. Bare `vX` is the Go era and stays on `dots-releases`.

## Layout per tag

`dots_darwin_arm64`, `dots_darwin_amd64`, `dots_linux_arm64`,
`dots_linux_amd64`, same four `dotsd_*`, `dots-config.tar.gz`,
`bootstrap-release.sh`, `dots.sh`, `checksums.txt` + `.sig`,
`release.json` + `.sig`.
