# Vercel Analytics

**Status:** Resource ladder populated from official Vercel docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Vercel Analytics** row — Signal: "Measuring site usage".

## Rule

Enable Vercel Web Analytics and Speed Insights by mounting `<Analytics />` and `<SpeedInsights />` in `app/layout.tsx` after enabling both products in the Vercel dashboard. Web Analytics tracks pageviews / referrers / custom events (product funnel signal); Speed Insights tracks Core Web Vitals (performance-as-product signal).

## Common patterns

- Install and mount `@vercel/analytics/next` in the root layout — [Vercel Analytics quickstart](https://vercel.com/docs/analytics/quickstart)
- Install and mount `@vercel/speed-insights/next` alongside it — [Speed Insights quickstart](https://vercel.com/docs/speed-insights/quickstart)
- Enable each product per-project in the Vercel dashboard sidebar before data flows — [Vercel Analytics quickstart](https://vercel.com/docs/analytics/quickstart)
- Track product-goal funnels via `track()` custom events (signups, CTA clicks, purchases) — [Vercel Analytics custom events](https://vercel.com/docs/analytics/custom-events)
- Use `beforeSend` / `debug` / `mode` options to filter PII and validate locally — [Vercel Analytics package](https://vercel.com/docs/analytics/package)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None. | N/A | N/A |
| 2 | `vercel` (no dedicated analytics CLI; data accessed via dashboard) | 52.0.0 | [vercel.com/docs/cli](https://vercel.com/docs/cli) · [Using Web Analytics](https://vercel.com/docs/analytics/using-web-analytics) |
| 3 | None — Vercel MCP does not expose analytics tools. Its tool surface covers projects, deployments, runtime logs, and domains only. | N/A | [vercel-mcp tools](https://vercel.com/docs/agent-resources/vercel-mcp/tools) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.

Package reference: `@vercel/analytics` v2.0.1, `@vercel/speed-insights` v2.0.0.
