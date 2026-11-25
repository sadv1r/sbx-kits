# pi-refuseless

Add the [Refuseless](https://refuseless.com) model provider to Pi in a Docker Sandbox. The mixin packages [`pi-refuseless`](https://github.com/kylinholmes/pi-refuseless) v0.1.1 from an immutable, checksum-verified source.

```sh
# Save the Refuseless API key once on the host.
sbx secret set refuseless
```

## Usage

With the published kits:

```sh
sbx run --kit ghcr.io/sadv1r/pi-refuseless \
        ghcr.io/sadv1r/pi /path/to/project
```

Or from a git URL targeting this repository:

```sh
sbx run --kit "git+https://github.com/sadv1r/sbx-kits.git#dir=pi-refuseless" \
        "git+https://github.com/sadv1r/sbx-kits.git#dir=pi" \
        /path/to/project
```

Or with a local clone:

```sh
sbx run --kit ./pi-refuseless ./pi /path/to/project
```

Inside Pi, open `/model` and choose a model under **Refuseless**.

## Without Docker Sandboxes

Install the same pinned extension directly into a local Pi installation:

```sh
pi install npm:pi-refuseless@0.1.1
```

Then set `REFUSELESS_API_KEY` or run `pi login refuseless`.
