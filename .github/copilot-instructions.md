# GitHub Copilot Instructions

## How to read this repo

1. The binding source of truth is the [root `README.md`](../README.md) — Mission, Business Principles, Technology Principles, the auto-generated Standard Platform table, and the auto-generated Workflow table.
2. **Tool selections live in [`bindings.yaml`](../bindings.yaml).** Read it; do not invent a tool. The README's tables are *generated* from this manifest plus [`layers/`](../layers/) — never hand-edit between the `<!-- generated:* -->` markers.
3. **The 16 layers under [`layers/`](../layers/)** are the workflow. Per-layer instructions live in `layers/XX-{slug}/layer.md`.
4. Generic agent conventions live in [`docs/agents/`](../docs/agents/). Read that before offering suggestions.

## Copilot-specific notes

- **Inline completion is not in scope.** This project favours scoped agent-mode edits over inline autocomplete.
- **Pattern A:** when offering a code change, identify which layer it belongs to. If it's scaffold change (orchestration, layers, bindings), it goes through the maintenance layer's supersede flow. If it's application code under `src/`, it follows the regular layer 09 (Recursive Build) flow.
- **Lock-once:** files under `intent/` are immutable after commit. Never propose an edit to one — propose a new artifact with `supersedes` set to the prior id.

## Non-duplication rule

Conventions belong in [`docs/agents/`](../docs/agents/). Per-layer instructions belong in `layers/XX-{slug}/layer.md`. This file routes; it does not redeclare.
