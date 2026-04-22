# GitHub

**Status:** Resource ladder populated from official GitHub docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **GitHub** row — Signal: "Hosting source + collaboration".

## Rule

Use GitHub as the source-of-truth host for code and collaboration. Protect `main` via repository rulesets that require pull-request review, passing status checks, and signed commits before merge. Define ownership in a root `CODEOWNERS` file to auto-request reviews.

## Common patterns

- Protect `main` with a repository ruleset (require PR, signed commits, status checks) — [GitHub docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets)
- Require pull-request review before merge — [GitHub docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- Require passing status checks before merge — [GitHub docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule)
- Define reviewers with a root `CODEOWNERS` file — [GitHub docs](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- Available ruleset rules reference — [GitHub docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no GitHub-published agent-skill package under github.com/github. `github/awesome-copilot` is explicitly community-sourced, not official. | N/A | N/A |
| 2 | `gh` | 2.91.0 | [cli.github.com/manual](https://cli.github.com/manual/) · [releases](https://github.com/cli/cli/releases) |
| 3 | GitHub MCP Server (`github/github-mcp-server`) | 1.0.1 | [github.com/github/github-mcp-server](https://github.com/github/github-mcp-server) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
