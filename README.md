# sbx-kits

Docker Sandbox kits for running coding agents with the `sbx` CLI.

- **Workloads** run an agent: [Pi](pi/), [omp](omp/), or [OpenCode](https://github.com/docker/sbx-kits-contrib/tree/v3/opencode).
- **Mixins** extend a compatible workload: [Codex OAuth](codex-oauth/) adds Codex sign-in, [Axon](axon/) adds Axon models, [pi-refuseless](pi-refuseless/) adds Refuseless models to Pi, [pi-usage](pi-usage/) adds usage and balance reporting to Pi, [rpiv-ask-user-question](rpiv-ask-user-question/) adds interactive questionnaires to Pi, and [pi-subagents](pi-subagents/) adds subagent delegation and workflows to Pi.

## Publish to GitHub Container Registry

GitHub Actions builds kits for Linux amd64 and arm64 and pushes each to GHCR as `:latest`. No Git tag or GitHub Release is needed.
The workflow uses the repository's `GITHUB_TOKEN`; no PAT secret is required for CI.
If a package already exists, grant this repository write access in the package's **Manage Actions access** settings.

On the sbx host, allow `ghcr.io/sadv1r/` as a kit source. With the default allowlist, use the command below;
if you already allow other prefixes, include them too because this setting replaces the list.

```sh
sbx settings set kit.allowedSources '["docker.io/","ghcr.io/sadv1r/"]'
```

For private packages, configure a host pull credential once (the `gh` token must have package read access):

```sh
gh auth token | sbx secret set --registry ghcr.io --password-stdin
```

After all publish jobs succeed, run from the project directory:

```sh
sbx run --kit ghcr.io/sadv1r/axon \
        --kit ghcr.io/sadv1r/codex-oauth \
        ghcr.io/sadv1r/omp .
```
