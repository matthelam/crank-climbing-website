# Vercel

**Status:** Resource ladder populated from official Vercel docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Vercel** row — Signal: "Deploying the application".

## Rule

Deploy the Next.js app via Vercel's Git integration as the primary path — connect the repo so each commit/PR produces a Preview deployment and `main` promotes to Production. Reserve `vercel --prod` from the CLI for manual or CI workflows only.

## Common patterns

- Connect repo via Vercel for GitHub for auto preview + production — [Vercel docs](https://vercel.com/docs/git/vercel-for-github)
- Use the three default environments (Local, Preview, Production) — [Vercel docs](https://vercel.com/docs/deployments/environments)
- Configure framework auto-detection and build settings for Next.js — [Vercel docs](https://vercel.com/docs/frameworks/full-stack/nextjs)
- Manage env vars per environment via `vercel env` or the dashboard — [Vercel docs](https://vercel.com/docs/cli/env)
- Authenticate CI/CD with `VERCEL_TOKEN`, not interactive login — [Vercel docs](https://vercel.com/docs/cli)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | `vercel-labs/agent-skills` (includes `vercel-deploy-claimable`) | Unversioned repo; pin to commit SHA | [github.com/vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) · [vercel.com/docs/agent-resources/skills](https://vercel.com/docs/agent-resources/skills) |
| 2 | `vercel` | 52.0.0 | [vercel.com/docs/cli](https://vercel.com/docs/cli) |
| 3 | None — covered by the Vercel MCP row separately. | N/A | see [vercel-mcp.md](vercel-mcp.md) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
