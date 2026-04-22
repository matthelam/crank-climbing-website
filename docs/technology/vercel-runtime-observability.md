# Vercel runtime observability

**Status:** Resource ladder populated from official Vercel docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Vercel runtime observability** row — Signal: "Capturing runtime logs and errors".

## Rule

Runtime logs and errors from Vercel Functions (serverless, edge, middleware) are captured automatically by the Vercel runtime and accessed via the Observability tab in the dashboard, the `vercel logs` CLI, or the REST Logs API. For retention beyond Vercel's UI window, forward logs to an external endpoint via Drains.

## Common patterns

- View and stream live runtime logs with `vercel logs --follow` — [vercel logs CLI](https://vercel.com/docs/cli/logs)
- Filter errors over a time window, e.g. `vercel logs --level error --since 1h` — [vercel logs CLI](https://vercel.com/docs/cli/logs)
- Scope to a source such as serverless or edge functions: `vercel logs --source edge-function --source serverless` — [vercel logs CLI](https://vercel.com/docs/cli/logs)
- Forward logs, traces, and analytics to an external endpoint via Drains for long-term retention — [Vercel Drains](https://vercel.com/docs/drains)
- Pull logs programmatically via `GET /v1/projects/{projectId}/deployments/{deploymentId}/runtime-logs` — [Vercel REST Logs API](https://vercel.com/docs/rest-api/logs/get-logs-for-a-deployment)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None. | N/A | N/A |
| 2 | `vercel logs` (sub-command of the Vercel CLI) | 52.0.0 | [vercel.com/docs/cli/logs](https://vercel.com/docs/cli/logs) |
| 3 | Covered by Vercel MCP — tool `get_runtime_logs` on `https://mcp.vercel.com` | Hosted service (no pinned version) | [vercel-mcp tools](https://vercel.com/docs/agent-resources/vercel-mcp/tools) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
