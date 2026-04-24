# Storybook MCP

**Status:** Resource ladder scaffolded; version cells marked *[verify]* — pin before lock-once.

Detail page for the Standard Platform **Storybook MCP** entry — Signal: "Driving Storybook stories and reading component state from an agent".

## Rule

Invoke the Storybook MCP server to navigate the running Storybook instance — list stories, render variants, capture state, and exercise `play` interactions — when an agent needs to work with components in isolation. Use it for component-scoped iteration and verification; defer to **Chrome DevTools MCP** for full-page runtime inspection and **Playwright MCP** for cross-route browser automation.

## Common patterns

- Connect to a running `storybook dev` instance (or built static Storybook) via the MCP client config — [Storybook docs](https://storybook.js.org/docs)
- Enumerate stories before acting: list → select by component + variant → render → snapshot
- Pair with the test runner for verification: render a story via MCP, then run its `play` assertions through the CLI rather than reimplementing them in the agent
- Prefer MCP-driven story iteration over screenshot-only loops; stories already encode the canonical states
- Keep MCP usage scoped to Storybook's surface area — for app-level routes, switch to Playwright MCP or Chrome DevTools MCP

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no Storybook-published Claude Code skill at the time of writing. | N/A | N/A |
| 2 | N/A — MCP server, invoked via MCP protocol. | N/A | N/A |
| 3 | Storybook MCP server (vendor-published; install per Storybook MCP docs) | *[verify]* | [storybook.js.org/docs](https://storybook.js.org/docs) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
