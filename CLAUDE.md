# CLAUDE.md

Claude Code session grounding.

## How to read this repo

1. The binding source of truth is the [root `README.md`](README.md) — Business Principles, Technology Principles, Standard Platform, Workflow, and Documentation routers.
2. Generic agent conventions — session-start protocol, tool dispatch, context compaction, ambiguity protocol, citation, lock-once discipline — live in [`docs/agents/`](docs/agents/). This file **does not duplicate those conventions**.
3. Only Claude-Code-specific material goes in this file.

## Claude-Code-specific layer *[TBD]*

Only content that is unique to the Claude Code platform belongs here. Everything else routes to `docs/agents/`.

- **Permissions and hooks** — [`.claude/settings.json`](.claude/settings.json) *[TBD]*.
- **Skills** — [`.claude/skills/`](.claude/skills/) *[TBD]*.
- **Subagents** — [`.claude/agents/`](.claude/agents/) *[TBD]*.
- **Slash commands** — [`.claude/commands/`](.claude/commands/) *[TBD]*.
- **MCP server configuration** — to document once the first project-scoped MCP server is wired.

## Non-duplication rule

If a rule applies to any agent that reads this repo (Copilot, a LangGraph node, a generic AGENTS.md reader), it belongs in [`docs/agents/`](docs/agents/), not here. This file's scope is strictly platform-specific behaviour.
