# Pi

Run [Pi](https://pi.dev), a minimal extensible terminal coding agent, in a Docker Sandbox.

The kit installs the latest Pi release by default, accepts an exact release through its `version` build argument, includes `fd` for Pi's find tool, supports shared agent skills, and sends clipboard copies to the attached terminal with OSC 52.

## Usage

```sh
sbx run ghcr.io/sadv1r/pi /path/to/project
```

Or from a git URL targeting this repo:
```sh
sbx run 'git+https://github.com/sadv1r/sbx-kits.git#dir=pi' /path/to/project
```

Or with a local clone of this repo:
```sh
sbx run ./pi /path/to/project
```
