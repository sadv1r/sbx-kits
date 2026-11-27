# pi-subagents

Add [`npm:pi-subagents`](https://www.npmjs.com/package/pi-subagents) v0.90.0 to Pi in a Docker Sandbox. The mixin bundles the extension, runtime dependencies, skills, and prompt templates. Pi discovers them automatically; no `pi install` or settings changes are needed.

## Usage

With the published kits:

```sh
sbx run --kit ghcr.io/sadv1r/pi-subagents \
        ghcr.io/sadv1r/pi /path/to/project
```

Or with a local clone:

```sh
sbx run --kit ./pi-subagents ./pi /path/to/project
```

Ask Pi to delegate a task to a subagent, or start a workflow with a prompt template such as `/parallel-research`.
