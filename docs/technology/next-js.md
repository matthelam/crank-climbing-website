# Next.js

**Status:** Resource ladder populated from official Vercel docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Next.js** row — Signal: "Building an application page or route".

## Rule

Use the Next.js App Router with file-system routing: place a `page.tsx` inside an `app/` directory folder to create a route, and use `layout.tsx` for shared UI. Every greenfield scaffold starts from `create-next-app` on the current stable (16.2) to inherit this by default.

## Common patterns

- Create a page via `app/<segment>/page.tsx` default-exporting a React component — [Next.js docs](https://nextjs.org/docs/app/getting-started/layouts-and-pages)
- Share UI with a root `app/layout.tsx` that renders `{children}` inside `<html><body>` — [Next.js docs](https://nextjs.org/docs/app/api-reference/file-conventions/layout)
- Nest folders for nested routes; wrap a segment in `[brackets]` for dynamic segments — [Next.js docs](https://nextjs.org/docs/app/api-reference/file-conventions/dynamic-routes)
- Build JSON/HTTP endpoints with `route.ts` Route Handlers colocated in the `app/` tree — [Next.js docs](https://nextjs.org/docs/app/getting-started/route-handlers)
- Navigate with `next/link` for prefetching and client-side transitions instead of raw `<a>` — [Next.js docs](https://nextjs.org/docs/app/api-reference/components/link)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — Vercel does not publish a Next.js skill package. Closest equivalents: auto-generated `AGENTS.md` in `create-next-app` and the `llms.txt` index. | N/A | [nextjs.org/docs/llms.txt](https://nextjs.org/docs/llms.txt) |
| 2 | `next` | 16.2.4 | [nextjs.org/docs/app/api-reference/cli/next](https://nextjs.org/docs/app/api-reference/cli/next) |
| 3 | None — covered by the Next.js DevTools MCP row separately. | N/A | see [next-js-devtools-mcp.md](next-js-devtools-mcp.md) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
