# Codex OAuth

Add Codex OAuth to a Docker Sandbox workload.

```sh
# Sign in once on the host
sbx secret set openai --oauth
```

## Usage

## OpenCode example

```sh
sbx run --kit ghcr.io/sadv1r/codex-oauth opencode /path/to/project
```

Or from a git URL targeting this repo:
```sh
sbx run --kit "git+https://github.com/sadv1r/sbx-kits.git#dir=codex-oauth" opencode /path/to/project
```

Or with a local clone of this repo:
```sh
sbx run --kit ./codex-oauth opencode /path/to/project
```

## Pi Agent example

```sh
sbx run --kit ghcr.io/sadv1r/codex-oauth sbx/pi /path/to/project
```

Or from a git URL targeting this repo:
```sh
sbx run --kit "git+https://github.com/sadv1r/sbx-kits.git#dir=codex-oauth" sbx/pi /path/to/project
```

Or with a local clone of this repo:
```sh
sbx run --kit ./codex-oauth sbx/pi /path/to/project
```

## omp example

```sh
sbx run --kit ghcr.io/sadv1r/codex-oauth ./my-omp /path/to/project
```

Or from a git URL targeting this repo:
```sh
sbx run --kit 'git+https://github.com/sadv1r/sbx-kits.git#dir=codex-oauth' ./my-omp /path/to/project
```

Or with a local clone of this repo:
```sh
sbx run --kit ./codex-oauth ./my-omp /path/to/project
```
