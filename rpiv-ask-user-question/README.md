# rpiv-ask-user-question

Add [`npm:@juicesharp/rpiv-ask-user-question`](https://www.npmjs.com/package/@juicesharp/rpiv-ask-user-question) v2.16.0 to Pi in a Docker Sandbox. The mixin bundles the extension and its `rpiv-config` dependency from checksum-verified npm releases. Pi loads it automatically; no `pi install` step or settings changes are needed.

## Usage

With the published kits:

```sh
sbx run --kit ghcr.io/sadv1r/rpiv-ask-user-question \
        ghcr.io/sadv1r/pi /path/to/project
```

Or with a local clone:

```sh
sbx run --kit ./rpiv-ask-user-question ./pi /path/to/project
```

In an interactive Pi session, the model can call `ask_user_question` to show a questionnaire with selectable answers. The tool is not exposed in non-interactive print mode.
