# syntax=docker/dockerfile:1.7
FROM docker.io/library/busybox:1.37.0@sha256:a7dbc319b1438115a207e11930dc4bb3e643dcb3ec0bdd694bb36cd8fad289ec AS source

ADD --checksum=sha256:4105b14ae16008ab1698e15e0e784419af61058488ea90fef4831ad5454023f3 \
    https://registry.npmjs.org/@juicesharp/rpiv-ask-user-question/-/rpiv-ask-user-question-2.16.0.tgz \
    /tmp/rpiv-ask-user-question.tgz
ADD --checksum=sha256:18355733c33a9a303540290e550f0ce799d8394462da5481d57f120c3529a3db \
    https://registry.npmjs.org/@juicesharp/rpiv-config/-/rpiv-config-2.16.0.tgz \
    /tmp/rpiv-config.tgz

# Pi supplies its own TUI, agent, and TypeBox peer dependencies.
RUN mkdir -p /out/node_modules/@juicesharp/rpiv-config && \
    tar -xzf /tmp/rpiv-ask-user-question.tgz -C /out --strip-components=1 && \
    tar -xzf /tmp/rpiv-config.tgz -C /out/node_modules/@juicesharp/rpiv-config --strip-components=1

FROM scratch

COPY --from=source --chown=1000:1000 /out/ \
    /home/agent/.pi/agent/extensions/rpiv-ask-user-question/
