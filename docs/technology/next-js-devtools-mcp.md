# Next.js DevTools MCP

**Status:** Resource ladder populated from official Vercel / Next.js docs as of 2026-04-22.

Detail page for the Standard Platform **Next.js DevTools MCP** entry — Signal: "Looking up framework or Vercel documentation".

## Rule

Invoke Next.js DevTools MCP whenever working on Next.js 16+ code — for live error/route/metadata queries against the running dev server, framework doc lookup, and Cache Components / Next 16 upgrade workflows — instead of hand-fetching docs or guessing at build state. Skip the MCP only for pure prose/UX tasks that don't touch framework code.

## Common patterns

- Install via `.mcp.json` at the project root with `npx -y next-devtools-mcp@latest` — [nextjs.org/docs/app/guides/mcp](https://nextjs.org/docs/app/guides/mcp)
- Call `get_errors` to pull current build / runtime / type errors from the dev server — [nextjs.org/docs/app/guides/mcp](https://nextjs.org/docs/app/guides/mcp)
- Call `get_routes` / `get_page_metadata` / `get_project_metadata` for app-router layout context — [nextjs.org/docs/app/guides/mcp](https://nextjs.org/docs/app/guides/mcp)
- Use the Next.js knowledge base plus `upgrade_nextjs_16` / Cache Components helpers for migrations — [github.com/vercel/next-devtools-mcp](https://github.com/vercel/next-devtools-mcp)
- Auto-discovers any running dev server via the built-in `/_next/mcp` endpoint — [nextjs.org/docs/app/guides/mcp](https://nextjs.org/docs/app/guides/mcp)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no Vercel- or Anthropic-published Claude skill for this MCP as of 2026-04-22. | N/A | N/A |
| 2 | N/A — MCP server, invoked via MCP protocol. | N/A | N/A |
| 3 | `next-devtools-mcp` (npm package `next-devtools-mcp`) | 0.3.10 | [github.com/vercel/next-devtools-mcp](https://github.com/vercel/next-devtools-mcp) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
