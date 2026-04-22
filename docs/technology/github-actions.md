# GitHub Actions

**Status:** Resource ladder populated from official GitHub docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **GitHub Actions** row — Signal: "Running CI on every push".

## Rule

Every push and pull request to the default branch MUST trigger a GitHub Actions workflow defined in `.github/workflows/` that checks out with `actions/checkout`, provisions Node via `actions/setup-node` (with `cache: 'npm'`), and runs install / build / test. Grant least-privilege `permissions: contents: read` at the workflow level.

## Common patterns

- Workflow file at `.github/workflows/ci.yml` with `on: [push, pull_request]` — [GitHub docs](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#on)
- `actions/checkout@v4` + `actions/setup-node@v4` with `node-version` and `cache: 'npm'` — [GitHub docs](https://docs.github.com/en/actions/tutorials/build-and-test-code/nodejs)
- Matrix strategy for multi-version Node testing (`strategy.matrix.node-version`) — [GitHub docs](https://docs.github.com/en/actions/tutorials/build-and-test-code/nodejs#specifying-the-nodejs-version)
- Pin third-party actions to a full commit SHA for supply-chain security — [GitHub docs](https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions#using-third-party-actions)
- Set `permissions:` at workflow or job scope to minimum required tokens — [GitHub docs](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#permissions)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no official Agent Skill package; workflow authoring is covered by GitHub Docs and starter templates only. | N/A | [docs.github.com/en/actions/get-started/quickstart](https://docs.github.com/en/actions/get-started/quickstart) |
| 2 | N/A — workflows run on GitHub-hosted infrastructure. `act` is third-party; self-hosted runners are the only official off-GitHub execution path. | N/A | [docs.github.com/en/actions/concepts/runners/self-hosted-runners](https://docs.github.com/en/actions/concepts/runners/self-hosted-runners) |
| 3 | GitHub MCP Server (`github/github-mcp-server`) — `actions` toolset (list workflows, trigger runs, cancel runs, fetch run logs) | 1.0.1 | [github.com/github/github-mcp-server](https://github.com/github/github-mcp-server) · [toolset configuration](https://docs.github.com/en/copilot/how-tos/provide-context/use-mcp/configure-toolsets) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
