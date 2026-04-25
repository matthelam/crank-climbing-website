# AGENTS.md

Generic agent grounding, per the cross-tool [AGENTS.md convention](https://agents.md/). Any agent — Claude Code, Copilot, a LangGraph node, a Cursor session — reads this file to orient.

## How to read this repo

1. The binding source of truth is the [root `README.md`](README.md) — Mission, Business Principles, Technology Principles, the auto-generated Standard Platform table, and the auto-generated Workflow table.
2. **Tool selections live in [`bindings.yaml`](bindings.yaml).** Read it; do not invent. The README's tables are *generated* from this manifest plus [`layers/`](layers/) — never hand-edit between the `<!-- generated:* -->` markers.
3. **The 16 layers under [`layers/`](layers/)** are the workflow. Each layer has a contract (`layer.md`), input/output JSON Schemas, gates (`gates.yaml`), a Claude Code skill, and a LangGraph subgraph.
4. Generic agent conventions live in [`docs/agents/`](docs/agents/). Read that directory before acting.
5. Platform-specific behaviour lives in its own entry point:
   - [`CLAUDE.md`](CLAUDE.md) — Claude Code.
   - [`.github/copilot-instructions.md`](.github/copilot-instructions.md) — GitHub Copilot.
   - LangGraph nodes under [`orchestration/`](orchestration/) reference `docs/agents/` by path.

## Bootstrapping

Run [`scripts/bootstrap.ps1`](scripts/bootstrap.ps1) on first clone (Windows + PowerShell required). The bootstrap layer (00) converges the local environment to the declared state in [`bindings.yaml`](bindings.yaml) and [`infrastructure/`](infrastructure/).

## Non-duplication rule

This file routes; it does not redeclare. Conventions belong in `docs/agents/`. Per-layer instructions belong in `layers/XX-{slug}/layer.md`. Per-tool reference belongs in `docs/technology/` (auto-generated stubs). When a platform-specific file is needed, it carries only what is unique to its platform and routes the rest here.
