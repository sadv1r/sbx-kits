# Codex OAuth

Add Codex OAuth to a Docker Sandbox workload.

```sh
# Sign in once on the host
sbx secret set openai --oauth
```

## Pi Agent example

```sh
sbx run --kit ./codex-oauth sbx/pi /path/to/project
```

## omp example

```sh
sbx run --kit ./codex-oauth ./my-omp /path/to/project
```
