import { streamSimple } from "@earendil-works/pi-ai/compat";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Pi reads the account claim before it builds a Codex request. Docker keeps
// that claim on the host. This unsigned token is only used by Pi's serializer.
const claims = { "https://api.openai.com/auth": { chatgpt_account_id: "sandbox" } };
const localToken = `eyJhbGciOiJub25lIn0.${Buffer.from(JSON.stringify(claims)).toString("base64url")}.`;

export default function (pi: ExtensionAPI) {
  const sentinel = process.env.OPENAI_CODEX_OAUTH_TOKEN;
  if (!sentinel) return;

  pi.registerProvider("openai-codex", {
    apiKey: "$OPENAI_CODEX_OAUTH_TOKEN",
    api: "openai-codex-responses",
    streamSimple(model, context, options) {
      if (options?.apiKey !== sentinel) return streamSimple(model, context, options);

      return streamSimple({ ...model, baseUrl: "https://chatgpt.com/backend-api" }, context, {
        ...options,
        apiKey: localToken,
        // Pi's SSE transport uses the per-request fetch hook.
        transport: "sse",
        fetch(url, init) {
          const headers = new Headers(init?.headers);
          headers.delete("chatgpt-account-id");
          headers.set("authorization", `Bearer ${sentinel}`);
          return (options.fetch ?? globalThis.fetch)(url, { ...init, headers });
        },
      });
    },
  });
}
