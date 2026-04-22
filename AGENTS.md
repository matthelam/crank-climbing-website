# AGENTS.md

Generic agent grounding, per the cross-tool [AGENTS.md convention](https://agents.md/). Any agent — Claude Code, Copilot, a LangGraph node, a Cursor session — reads this file to orient.

## How to read this repo

1. The binding source of truth is the [root `README.md`](README.md) — Business Principles, Technology Principles, Standard Platform, Workflow, Documentation.
2. Generic agent conventions — session-start, tool dispatch, context compaction, ambiguity protocol, citation conventions, lock-once discipline — live in [`docs/agents/`](docs/agents/). Read that directory before acting.
3. Platform-specific behaviour lives in its own entry point:
   - [`CLAUDE.md`](CLAUDE.md) — Claude Code.
   - [`.github/copilot-instructions.md`](.github/copilot-instructions.md) *[TBD]* — GitHub Copilot.
   - LangGraph node prompts under [`orchestration/`](orchestration/) reference `docs/agents/` inline.

## Non-duplication rule

This file routes; it does not redeclare. Conventions belong in `docs/agents/`. When a platform-specific file is needed, it carries only what is unique to its platform and routes the rest here.
