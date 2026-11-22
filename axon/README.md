# Axon

Add [Axon](https://axon.bz/) models to a Docker Sandbox workload.

```sh
# Save Axon API key once on the host
sbx secret set axon
```

## Usage

## OpenCode example

```sh
sbx run --kit ghcr.io/sadv1r/axon opencode /path/to/project
```

Or from a git URL targeting this repo:
```sh
sbx run --kit "git+https://github.com/sadv1r/sbx-kits.git#dir=axon" opencode /path/to/project
```

Or with a local clone of this repo:
```sh
sbx run --kit ./axon opencode /path/to/project
```

## Pi Agent example

```sh
sbx run --kit ghcr.io/sadv1r/axon sbx/pi /path/to/project
```

Or from a git URL targeting this repo:
```sh
sbx run --kit "git+https://github.com/sadv1r/sbx-kits.git#dir=axon" sbx/pi /path/to/project
```

Or with a local clone of this repo:
```sh
sbx run --kit ./axon sbx/pi /path/to/project
```

## omp example

```sh
sbx run --kit ghcr.io/sadv1r/axon ./omp /path/to/project
```

Or from a git URL targeting this repo:
```sh
sbx run --kit 'git+https://github.com/sadv1r/sbx-kits.git#dir=axon' ./omp /path/to/project
```

Or with a local clone of this repo:
```sh
sbx run --kit ./axon ./omp /path/to/project
```
