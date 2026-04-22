# Playwright MCP

**Status:** Resource ladder populated from official Microsoft / Playwright docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Playwright MCP** entry — Signal: "Automating a browser (scripted interactions)".

## Rule

Use Playwright MCP for browser automation (navigate, click, form-fill, snapshot). Do not hand-write scripts against the Playwright test runner from the agent. Prefer the accessibility-snapshot tools over screenshots, and target deterministic roles / names rather than brittle CSS selectors.

## Common patterns

- Install via `npx @playwright/mcp@latest` in MCP client config — [playwright-mcp](https://github.com/microsoft/playwright-mcp)
- Prefer accessibility-snapshot mode (default) over `--caps=vision` for determinism — [playwright-mcp](https://github.com/microsoft/playwright-mcp)
- Isolate sessions with `--isolated` for ephemeral browser profiles in CI / greenfield work — [playwright-mcp](https://github.com/microsoft/playwright-mcp)
- Use `browser_snapshot` + role / name targeting before `browser_click` / `browser_type` — [playwright-mcp](https://github.com/microsoft/playwright-mcp)
- Gate dangerous capabilities (`pdf`, `tracing`, `vision`) behind explicit `--caps` flags — [playwright-mcp](https://github.com/microsoft/playwright-mcp)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no Anthropic-published skill; Microsoft's upcoming SKILL-mode lives in `playwright-cli`, not `playwright-mcp`. | N/A | N/A |
| 2 | N/A — MCP server, invoked via MCP protocol. | N/A | N/A |
| 3 | `@playwright/mcp` (Playwright MCP server) | v0.0.70 (2026-04-01) | [github.com/microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
