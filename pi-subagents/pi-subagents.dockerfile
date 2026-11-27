# syntax=docker/dockerfile:1.7
FROM docker.io/library/node:24.13.0-alpine3.23@sha256:cd6fb7efa6490f039f3471a189214d5f548c11df1ff9e5b181aa49e22c14383e AS source

ADD --checksum=sha256:99ffc533c211ed9425b0b6941e7500615cae77109e68551b8de833de39a3460a \
    https://registry.npmjs.org/pi-subagents/-/pi-subagents-0.90.0.tgz \
    /tmp/pi-subagents.tgz

WORKDIR /out
# Pi supplies the peers. Pin jsbi, the only ranged runtime dependency.
RUN tar -xzf /tmp/pi-subagents.tgz --strip-components=1 && \
    npm install --omit=peer --ignore-scripts --no-audit --no-fund --no-save jsbi@4.3.2 && \
    printf 'export { default } from "./bundle/index.js";\n' > index.js

FROM scratch

COPY --from=source --chown=1000:1000 /out/ /home/agent/.pi/agent/extensions/pi-subagents/
COPY --from=source --chown=1000:1000 /out/skills/ /home/agent/.pi/agent/skills/
COPY --from=source --chown=1000:1000 /out/prompts/ /home/agent/.pi/agent/prompts/
