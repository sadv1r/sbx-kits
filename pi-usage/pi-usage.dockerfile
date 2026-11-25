# syntax=docker/dockerfile:1.7
FROM docker.io/library/busybox:1.37.0@sha256:a7dbc319b1438115a207e11930dc4bb3e643dcb3ec0bdd694bb36cd8fad289ec AS source

# sadv1r/pi-usage, pinned to its digest.
ADD --checksum=sha256:d445cf94dd9fa0adff093a526b330e4e10758ba930db0dfa015c84eb1bb487e7 \
    https://codeload.github.com/sadv1r/pi-usage/tar.gz/e045e6f82c83b7842379fcb85b5209009207c42e \
    /tmp/pi-usage.tgz
RUN mkdir -p /out && \
    tar -xzf /tmp/pi-usage.tgz -C /out --strip-components=1

FROM scratch

COPY --from=source --chown=1000:1000 /out/package.json \
    /home/agent/.pi/agent/extensions/pi-usage/package.json
COPY --from=source --chown=1000:1000 /out/src/ \
    /home/agent/.pi/agent/extensions/pi-usage/src/
COPY --from=source /out/LICENSE \
    /usr/share/licenses/pi-usage/LICENSE
COPY --chown=1000:1000 --chmod=0644 files/pi-usage.json \
    /home/agent/.pi/agent/pi-usage.json
