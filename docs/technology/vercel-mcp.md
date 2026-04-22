# Vercel MCP

**Status:** Resource ladder populated from official Vercel docs as of 2026-04-22.

Detail page for the Standard Platform **Vercel MCP** entry — Signal: "Looking up framework or Vercel documentation".

## Rule

Use Vercel MCP for read-only lookups only — documentation search, project / deployment / log inspection, and domain availability checks. Writes (deploys, domain purchases, protected-URL sharing) must go through the Standard Platform's deployment workflow, not ad-hoc tool calls.

## Common patterns

- Search Vercel docs before hand-rolling framework guidance — [vercel-mcp tools](https://vercel.com/docs/agent-resources/vercel-mcp/tools#search_documentation)
- Inspect deployment state and build logs to diagnose failures — [vercel-mcp tools](https://vercel.com/docs/agent-resources/vercel-mcp/tools#get_deployment_build_logs)
- Query runtime logs (filter by level, status, time window) for Next.js function debugging — [vercel-mcp tools](https://vercel.com/docs/agent-resources/vercel-mcp/tools#get_runtime_logs)
- Resolve project / team IDs via `list_projects` / `list_teams` from `.vercel/project.json` — [vercel-mcp tools](https://vercel.com/docs/agent-resources/vercel-mcp/tools#list_projects)
- Check domain availability before proposing production hostnames — [vercel-mcp tools](https://vercel.com/docs/agent-resources/vercel-mcp/tools#check_domain_availability_and_price)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None. | N/A | N/A |
| 2 | N/A — MCP server, invoked via MCP protocol. | N/A | N/A |
| 3 | Vercel MCP (official hosted remote MCP server) | Beta, hosted service at `https://mcp.vercel.com` (no semver; terms last updated 2026-02-12) | [vercel.com/docs/mcp/vercel-mcp](https://vercel.com/docs/mcp/vercel-mcp) · [vercel/vercel-mcp-overview](https://github.com/vercel/vercel-mcp-overview) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
