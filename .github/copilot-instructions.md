# GitHub Copilot Instructions

## How to read this repo

1. The binding source of truth is the [root `README.md`](../README.md) — Business Principles, Technology Principles, Standard Platform, Workflow, Documentation.
2. Generic agent conventions live in [`docs/agents/`](../docs/agents/). Read that before offering suggestions.
3. Only Copilot-specific behaviour belongs in this file.

## Copilot-specific layer *[TBD]*

Copilot's primary surface is inline code completion. The repo-wide conventions that apply:

- UI code: **Atomic Design** for component structure.
- Non-UI code: **SOLID** for module design.
- Tests precede code: **TDD** (red → green → refactor).

These are repeated here only because Copilot does not follow markdown links during inline completion — it needs them resident. Everything else a Copilot *chat* session needs lives in [`docs/agents/`](../docs/agents/) and should be consulted explicitly.

## Non-duplication rule

Conventions belong in [`docs/agents/`](../docs/agents/). Duplication in this file is limited to the three Engineering Practices listed above, which must be resident for inline completion to apply them.
