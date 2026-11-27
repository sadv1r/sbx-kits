# syntax=docker/dockerfile:1.7
# Adapted from Docker's Pi kit:
# https://github.com/docker/sbx-kits-contrib/blob/main/pi/Dockerfile
ARG BASE_IMAGE=docker.io/sbx/shell-docker-image:latest
FROM ${BASE_IMAGE}
# Re-declared inside the stage: an ARG defined before the first FROM is a global
# build arg, visible only to FROM lines. Without this, the LABEL below would
# expand to an empty string.
ARG BASE_IMAGE

# Pi's find tool uses fd. When neither `fd` nor `fdfind` exists, Pi downloads a
# release binary from GitHub at runtime; that download is outside this kit's
# network policy. Ubuntu packages the binary as `fdfind`, which Pi accepts.
# The `fd` symlink also provides the conventional command name at the shell.
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends fd-find && \
    rm -rf /var/lib/apt/lists/* && \
    ln -sf "$(command -v fdfind)" /usr/local/bin/fd

# The host mounts shared skills at ~/.agents/skills. Creating the parent in the
# image as agent prevents the runtime from creating a root-owned parent for the
# mount target.
USER agent
RUN mkdir -p /home/agent/.agents

# The sandbox is the isolation boundary. Trust projects by default without
# overriding explicit trust decisions.
RUN mkdir -p /home/agent/.pi/agent && \
    printf '%s\n' '{"defaultProjectTrust":"always"}' > /home/agent/.pi/agent/settings.json

# The v3 kit argument `version` maps to PI_VERSION. Fetching the npm release
# metadata with ADD makes its contents part of the build cache key. A new
# `latest` release triggers a reinstall, while an exact version keeps using its
# immutable metadata URL.
ARG PI_VERSION
# --chmod=644 because a URL ADD lands 0600 root-owned by default, and the RUN
# below reads this file as agent.
USER root
ADD --chmod=644 https://registry.npmjs.org/@earendil-works%2Fpi-coding-agent/${PI_VERSION} /tmp/pi-release.json

# The base image's global npm prefix is agent-owned. Installing as agent keeps
# Pi's files writable for `pi update` and `pi install` without recursively
# copying and chowning the inherited npm tree.
# Reading the resolved version from the fetched metadata makes the install a
# function of that cache input instead of resolving `latest` again. Pi does not
# require dependency lifecycle scripts, so the npm install disables them.
# Executing Pi gates the image on its actual Node compatibility.
USER agent
RUN set -eu; \
    version="$(node -p 'require("/tmp/pi-release.json").version')"; \
    npm install -g --ignore-scripts "@earendil-works/pi-coding-agent@${version}"; \
    pi --version

# The global npm bin directory is normally on PATH, but lifecycle and exec
# contexts may receive a minimal PATH. Keep an explicit symlink in a directory
# those contexts always search.
USER root
RUN ln -sf "$(npm prefix -g)/bin/pi" /usr/local/bin/pi

# The sandbox terminal, not a Wayland compositor inside the container, owns the
# user's clipboard. Pi otherwise prefers `wl-copy` whenever WAYLAND_DISPLAY is
# present and reports an unavailable clipboard when that socket or binary is
# inaccessible. This supported override makes Pi emit OSC 52 to the attached
# terminal, matching the clipboard path that works for omp.
ENV PI_CLIPBOARD_OSC52=1

# Inherited from the base image, but re-declared deliberately so the value is
# owned here rather than depending on inheritance.
#
# This is a request to the runtime, not a description of the image: setting it
# over a base with no Docker engine would request Docker mode with no engine.
LABEL com.docker.sandboxes.start-docker="true"

# Override the base image's inherited flavor. Otherwise sbx would identify this
# workload as `shell-docker` instead of `pi`.
LABEL com.docker.sandboxes.flavor="pi"

# Informational only. The base uses a floating tag, so this records which base
# reference produced the image.
LABEL com.docker.sandboxes.base="${BASE_IMAGE}"

# Set the launch user explicitly so a future root-only build step cannot change
# it accidentally. The agent's home is the fallback working directory when the
# launcher does not select a project directory.
USER agent
WORKDIR /home/agent
# agent-sessions appends `-p <prompt>` to this entrypoint for non-interactive
# runs, yielding `pi -p <prompt>`.
ENTRYPOINT ["pi"]
