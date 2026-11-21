# Axon

Add Axon models to a Docker Sandbox workload.

```sh
# Save Axon API key once on the host
sbx secret set axon
```

## OpenCode example

```sh
sbx run --kit ./axon sbx/opencode /path/to/project
```

## Pi Agent example

```sh
sbx run --kit ./axon sbx/pi /path/to/project
```

## omp example

```sh
sbx run --kit ./axon ./my-omp /path/to/project
```
