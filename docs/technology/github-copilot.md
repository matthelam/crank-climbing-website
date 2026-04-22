# GitHub Copilot

**Status:** Resource ladder populated from official GitHub docs as of 2026-04-22.

Detail page for the Standard Platform **GitHub Copilot** row — Signal: "IDE-embedded chat and scoped edits".

## Rule

Scope GitHub Copilot to Chat and agent-mode edits only — do not rely on inline completions in this repo. Ground Copilot behaviour via a repo-level `.github/copilot-instructions.md` (plus optional `.github/instructions/*.instructions.md` for path-scoped rules), per GitHub's documented custom-instructions precedence model.

## Common patterns

- Repository-wide instructions at `.github/copilot-instructions.md` plus path-scoped `.github/instructions/NAME.instructions.md` — [GitHub docs](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions)
- Copilot Chat modes (Ask / Plan / Agent) in the IDE; Agent mode authorised to edit files and run terminal commands — [GitHub docs](https://docs.github.com/en/copilot/how-tos/use-chat/use-chat-in-ide)
- `AGENTS.md` supported as an alternative agent-spec file resolved by nearest-in-tree precedence — [GitHub docs](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions)
- Copilot coding agent on github.com for background PR work (complements local agent-mode) — [GitHub docs](https://docs.github.com/en/copilot/concepts/about-copilot-coding-agent)
- Instruction precedence: personal > repository > organisation — [GitHub docs](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — `github/awesome-copilot` is self-described as a community-created collection, not an official GitHub product. | N/A | [github.com/github/awesome-copilot](https://github.com/github/awesome-copilot) |
| 2 | GitHub Copilot CLI (`copilot`) — standalone CLI. The legacy `gh copilot` gh-extension is retired. | 1.0.34 (2026-04-20) | [github.com/github/copilot-cli](https://github.com/github/copilot-cli) |
| 3 | GitHub MCP Server (`github/github-mcp-server`) — Copilot toolset (`assign_copilot_to_issue`, `request_copilot_review`, `create_pull_request_with_copilot`, `copilot_spaces`) | 1.0.1 (2026-04-21) | [github.com/github/github-mcp-server](https://github.com/github/github-mcp-server) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
