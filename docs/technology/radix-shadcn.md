# Radix via shadcn/ui

**Status:** Resource ladder populated from official shadcn/ui and Radix docs as of 2026-04-22.

Detail page for the Standard Platform **Radix** via **shadcn/ui** row — Signal: "Composing primitives (dialog, menu, tooltip, etc.)".

## Rule

Adopt shadcn/ui as the copy-in component layer on top of Radix Primitives. `shadcn@latest init` scaffolds `components.json`, and every primitive (dialog, dropdown menu, tooltip, etc.) is copied into the repo as source you own and modify — not imported from a package. For a greenfield Next.js repo, use the official Next.js template: `shadcn@latest init -t next`.

## Common patterns

- Install into Next.js via `pnpm dlx shadcn@latest init -t next` — [shadcn/ui docs](https://ui.shadcn.com/docs/installation/next)
- Add composable Radix-backed primitives on demand (`shadcn@latest add dialog`) — [shadcn CLI docs](https://ui.shadcn.com/docs/cli)
- Dialog / Alert Dialog wrapping Radix Dialog — [shadcn/ui Dialog](https://ui.shadcn.com/docs/components/dialog)
- Dropdown Menu wrapping Radix Dropdown Menu — [shadcn/ui Dropdown Menu](https://ui.shadcn.com/docs/components/dropdown-menu)
- Tooltip / Popover wrapping Radix primitives — [Radix Primitives docs](https://www.radix-ui.com/primitives/docs)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | `shadcn/skills` (official AI-agent skill bundle; ships with shadcn CLI v4, March 2026) | Tracks `shadcn` CLI v4 | [ui.shadcn.com/docs/skills](https://ui.shadcn.com/docs/skills) |
| 2 | `shadcn` (npm package `shadcn`; `shadcn-ui` is the deprecated legacy name) | 4.3.1 | [ui.shadcn.com/docs/cli](https://ui.shadcn.com/docs/cli) |
| 3 | shadcn Registry MCP (ships with the shadcn CLI; "Built by shadcn at Vercel") | Bundled with `shadcn@4.3.1` | [ui.shadcn.com/docs/mcp](https://ui.shadcn.com/docs/mcp) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
