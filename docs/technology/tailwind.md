# Tailwind CSS

**Status:** Resource ladder populated from official Tailwind Labs docs as of 2026-04-22.

Detail page for the Standard Platform **Tailwind CSS** row — Signal: "Styling an element".

## Rule

For a greenfield Next.js app, install Tailwind CSS v4 via the official `@tailwindcss/postcss` plugin and author styles using utility classes directly in JSX (`className="..."`). Configuration lives in CSS via `@import "tailwindcss"` and `@theme`; do **not** create a `tailwind.config.js` — that is the deprecated v3 pattern.

## Common patterns

- Install with the PostCSS plugin for Next.js — [Tailwind docs](https://tailwindcss.com/docs/guides/nextjs)
- Style with utility classes directly on elements — [Tailwind docs](https://tailwindcss.com/docs/styling-with-utility-classes)
- Responsive design via breakpoint prefixes (`md:`, `lg:`) — [Tailwind docs](https://tailwindcss.com/docs/responsive-design)
- Interactive state variants (`hover:`, `focus:`) stacked with other variants — [Tailwind docs](https://tailwindcss.com/docs/hover-focus-and-other-states)
- Dark mode via the `dark:` variant — [Tailwind docs](https://tailwindcss.com/docs/dark-mode)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — Tailwind Labs has not published an official agent skill package. Community request tracked in discussion #19594. | N/A | [tailwindlabs/tailwindcss#19594](https://github.com/tailwindlabs/tailwindcss/discussions/19594) |
| 2 | `@tailwindcss/cli` | 4.2.4 | [tailwindcss.com/docs/installation/tailwind-cli](https://tailwindcss.com/docs/installation/tailwind-cli) |
| 3 | None — no Tailwind Labs-published MCP server as of 2026-04-22. Community MCP discussion at #19737. | N/A | [tailwindlabs/tailwindcss#19737](https://github.com/tailwindlabs/tailwindcss/discussions/19737) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
