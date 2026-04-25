# CLAUDE.md

Claude Code session grounding.

## How to read this repo

1. The binding source of truth is the [root `README.md`](README.md) — Mission, Business Principles, Technology Principles, the auto-generated Standard Platform table, and the auto-generated Workflow table.
2. **Tool selections live in [`bindings.yaml`](bindings.yaml).** You read this; you do not invent tool choices. The README's tables are *generated* from this manifest plus [`layers/`](layers/) — never hand-edit between the `<!-- generated:* -->` markers.
3. **The 16 layers under [`layers/`](layers/)** are the workflow. Each layer has a contract (`layer.md`), input/output JSON Schemas, gates (`gates.yaml`), a Claude Code skill, and a LangGraph subgraph.
4. Generic agent conventions — session-start, tool dispatch, context compaction, ambiguity, citation, lock-once — live in [`docs/agents/`](docs/agents/). This file does **not** duplicate those conventions.

## Claude-Code-specific layer

Only content unique to the Claude Code platform belongs here. Everything else routes to `docs/agents/` or `layers/`.

- **Permissions and hooks** — [`.claude/settings.json`](.claude/settings.json). Currently `{}`; populate as the project's Claude Code surface grows.
- **Skills** — [`.claude/skills/`](.claude/skills/). One skill per layer (`layer-XX-{slug}/SKILL.md`), generated and refreshed by [`scripts/generate-skills.ps1`](scripts/generate-skills.ps1) from [`infrastructure/agent/skills.yaml`](infrastructure/agent/skills.yaml).
- **Subagents** — [`.claude/agents/`](.claude/agents/). Currently empty; add when a layer warrants one.
- **Slash commands** — [`.claude/commands/`](.claude/commands/). Currently empty.
- **MCP server configuration** — declared in [`infrastructure/mcp/servers.yaml`](infrastructure/mcp/servers.yaml); installed by the bootstrap layer.

## Bootstrapping

Run [`scripts/bootstrap.ps1`](scripts/bootstrap.ps1) on first clone. It is idempotent — safe to re-run anytime [`bindings.yaml`](bindings.yaml) or anything under [`infrastructure/`](infrastructure/) changes.

## Pattern A boundary

- **LangGraph orchestrates.** [`orchestration/`](orchestration/) — Python, LangGraph subgraphs per layer, root recursion graph.
- **Claude Code executes.** Each layer's work is performed by its skill, invoked by the LangGraph node via the Claude Agent SDK ([`orchestration/nodes/invoke_skill.py`](orchestration/nodes/invoke_skill.py)).

Deterministic gates (entry, exit, HITL, supersede) belong in nodes, not skill bodies.

## Non-duplication rule

If a rule applies to any agent that reads this repo (Copilot, AGENTS.md, a LangGraph node), it belongs in [`docs/agents/`](docs/agents/), not here. This file's scope is strictly platform-specific behaviour.
