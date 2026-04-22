# Claude Code

**Status:** Resource ladder populated from official Anthropic docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Claude Code** row — Signal: "Agent-driven repo operations".

## Rule

Treat Claude Code as the agent runtime for this greenfield Next.js repo. Commit a root `CLAUDE.md` plus scoped `.claude/` configuration (skills, subagents, commands, `settings.json`, `.mcp.json`) so agent behaviour is reproducible and version-controlled.

## Common patterns

- `CLAUDE.md` plus `.claude/rules/` for layered, path-scoped memory — [Claude Code memory docs](https://docs.claude.com/en/docs/claude-code/memory)
- Skills authored as `.claude/skills/<name>/SKILL.md` for both `/name` and autonomous invocation — [Claude Code slash commands](https://docs.claude.com/en/docs/claude-code/slash-commands)
- Subagents in `.claude/agents/` (Explore / Plan / general-purpose plus custom) — [Agent SDK subagents](https://docs.claude.com/en/docs/agent-sdk/subagents)
- Project MCP servers declared in `.mcp.json` at repo root (stdio / HTTP / SSE) — [Claude Code MCP docs](https://docs.claude.com/en/docs/claude-code/mcp)
- Plugins and marketplaces to distribute skills + commands + MCP as a bundle — [Anthropic announcement](https://www.anthropic.com/news/claude-code-plugins)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | `anthropics/skills` (official Agent Skills repo) | No tagged releases; pin to a commit SHA on `main` | [github.com/anthropics/skills](https://github.com/anthropics/skills) |
| 2 | `claude` (`@anthropic-ai/claude-code`) | 2.1.117 | [docs.claude.com/en/docs/claude-code/overview](https://docs.claude.com/en/docs/claude-code/overview) · [npm](https://www.npmjs.com/package/@anthropic-ai/claude-code) |
| 3 | Not applicable — Claude Code is an MCP client, not an MCP server. The relevant official guidance is Anthropic's Claude Code MCP configuration docs. | N/A | [docs.claude.com/en/docs/claude-code/mcp](https://docs.claude.com/en/docs/claude-code/mcp) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
