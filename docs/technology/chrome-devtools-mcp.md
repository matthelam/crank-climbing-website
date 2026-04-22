# Chrome DevTools MCP

**Status:** Resource ladder populated from official Chrome DevTools docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Chrome DevTools MCP** entry — Signal: "Inspecting a running page (DOM, network, logs)".

## Rule

Invoke `chrome-devtools-mcp` to inspect a running Next.js page — DOM, network, console, Lighthouse, performance traces — when diagnosing runtime behaviour the code alone cannot explain. Use it for live debugging and verification of AI-generated fixes, not as a replacement for automated test runners (Vitest / Playwright) in CI.

## Common patterns

- Verify an AI code fix against a live page (console + DOM + network) — [Chrome for Developers](https://developer.chrome.com/blog/chrome-devtools-mcp)
- Diagnose network / CORS errors via `list_network_requests` / `get_network_request` — [tool reference](https://github.com/ChromeDevTools/chrome-devtools-mcp/blob/main/docs/tool-reference.md)
- Reproduce layout bugs by inspecting live DOM/CSS via `take_snapshot` / `evaluate_script` — [Chrome for Developers](https://developer.chrome.com/blog/chrome-devtools-mcp)
- Run Lighthouse + performance traces (`lighthouse_audit`, `performance_start_trace`) for LCP / Core Web Vitals — [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- Detect memory leaks via `take_memory_snapshot` (added in v0.21.0) — [releases](https://github.com/ChromeDevTools/chrome-devtools-mcp/releases)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no Google-published Claude Code skill; skills are built into the MCP server itself. | N/A | N/A |
| 2 | N/A — MCP server, invoked via MCP protocol. | N/A | N/A |
| 3 | `chrome-devtools-mcp` (maintained by the Chrome DevTools team; install via `npx -y chrome-devtools-mcp@latest`) | v0.22.0 (2026-04-21) | [github.com/ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
