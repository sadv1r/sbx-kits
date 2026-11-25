# pi-usage

Add [`sadv1r/pi-usage`](https://github.com/sadv1r/pi-usage) to Pi in a Docker Sandbox. The mixin packages commit `e045e6f82c83b7842379fcb85b5209009207c42e` from an immutable, checksum-verified source and includes account configuration for Refuseless.

## Usage with Refuseless

Save the Refuseless API key once on the host:

```sh
sbx secret set refuseless
```

With the published kits:

```sh
sbx run --kit ghcr.io/sadv1r/pi-usage \
        --kit ghcr.io/sadv1r/pi-refuseless \
        ghcr.io/sadv1r/pi /path/to/project
```

Or from a git URL targeting this repository:

```sh
sbx run --kit "git+https://github.com/sadv1r/sbx-kits.git#dir=pi-usage" \
        --kit "git+https://github.com/sadv1r/sbx-kits.git#dir=pi-refuseless" \
        "git+https://github.com/sadv1r/sbx-kits.git#dir=pi" \
        /path/to/project
```

Or with a local clone:

```sh
sbx run --kit ./pi-usage --kit ./pi-refuseless ./pi /path/to/project
```

Inside Pi, enable the balance status:

```text
/usage on
```

Use `/usage query` for account and session details. The balance status is session-local and starts disabled after each restart or `/reload`.

The Refuseless account uses Pi's `refuseless` provider authentication. The `pi-refuseless` kit supplies that provider, its proxy-managed credential, and the required network policy; this kit owns the complete `pi-usage.json` file, so provider kits do not need to merge usage configuration.

## Without Docker Sandboxes

Install the same pinned extension directly into a local Pi installation:

```sh
pi install git:github.com/sadv1r/pi-usage@e045e6f82c83b7842379fcb85b5209009207c42e
```

Copy [`files/pi-usage.json`](files/pi-usage.json) to `~/.pi/agent/pi-usage.json`. Install and authenticate the Refuseless provider separately to enable its account query.
