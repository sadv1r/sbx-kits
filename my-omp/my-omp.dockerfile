# syntax=docker/dockerfile:1.7
# Adapted from Docker's Pi kit (Apache-2.0, see LICENSE.docker).
# https://github.com/docker/sbx-kits-contrib/blob/main/pi/Dockerfile
ARG BASE_IMAGE=docker.io/sbx/shell-docker-image:latest
FROM ${BASE_IMAGE}
# Re-declared inside the stage: an ARG defined before the first FROM is a global
# build arg, visible only to FROM lines. Without this, the LABEL below would
# expand to an empty string.
ARG BASE_IMAGE

# The v3 kit argument `version` maps to OMP_VERSION. Fetching the npm release
# metadata with ADD makes its contents part of the build cache key. A new
# latest release triggers a reinstall, while an exact version keeps using its
# own metadata URL.
ARG OMP_VERSION=latest
# --chmod=644 because a URL ADD lands 0600 root-owned by default, and the RUN
# below reads this file as agent.
ADD --chmod=644 https://registry.npmjs.org/@oh-my-pi%2Fpi-coding-agent/${OMP_VERSION} /tmp/omp-release.json

# Upstream installs to the invoking user's ~/.local/bin. Installing as agent
# keeps the binary agent-owned. The image PATH makes it available to sbx and
# the build-time check even when no interactive shell profile is loaded.
USER agent
ENV PATH="/home/agent/.local/bin:${PATH}"
# Pass the resolved tag to the installer so it downloads the same release
# that keyed the cache. The installer selects the platform binary and checks
# its checksum. Running omp by name also tests the PATH used at launch.
RUN set -eu; \
    version="$(jq -er '.version' /tmp/omp-release.json)"; \
    curl -fsSL https://omp.sh/install -o /tmp/install-omp.sh; \
    sh /tmp/install-omp.sh --binary --ref "v${version}"; \
    rm /tmp/install-omp.sh; \
    omp --version

# Inherited from the base image, but re-declared deliberately so the value is
# owned here rather than depending on inheritance.
#
# This is a *request* to the runtime, not a description of the image: setting it
# over a base with no Docker engine yields a sandbox started in Docker mode with
# nothing to run.
LABEL com.docker.sandboxes.start-docker="true"

# Both of the labels below OVERRIDE values inherited from the base image, which
# describe the base rather than this image. Overriding is not optional for
# `flavor`: left inherited it would read "shell-docker", and sbx would report
# this image's agent as "shell-docker". So it must be the kit's own name: `my-omp`.
LABEL com.docker.sandboxes.flavor="my-omp"

# Informational only -- nothing in sbx reads this. Worth setting because the
# base is a floating tag rebuilt nightly, so this is the one place the produced
# image records what it was actually built on.
LABEL com.docker.sandboxes.base="${BASE_IMAGE}"

# Set the launch user explicitly so a future root-only build step cannot
# change it by accident. The agent's home is the default working directory
# when the launcher does not select a project directory.
USER agent
WORKDIR /home/agent
CMD ["omp"]
