FROM scratch

# The sandbox proxy replaces this bearer token placeholder on requests
# to the resource host declared in codex-oauth.yaml.
ENV OPENAI_CODEX_OAUTH_TOKEN=oai-oat01-proxy-managed
