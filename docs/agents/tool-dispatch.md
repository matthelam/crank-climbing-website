# Tool dispatch

How to pick the right tool for a given task. The authoritative router is **[`bindings.yaml`](../../bindings.yaml)**, surfaced in the README's auto-generated Standard Platform table.

## How to dispatch

1. Identify the **capability** your task needs (e.g., "I need to style something" → capability `styling`; "I need to extract content from a live page" → capability `page_extraction`).
2. Look up that capability id in [`bindings.yaml`](../../bindings.yaml).
3. Use the `ai_binding.tool` at the pinned `ai_binding.version`. If your context is "human deliverable," use `human_binding.tool` instead.
4. Read the linked `docs_url` for usage. Per-tool elaborations live under [`docs/technology/`](../technology/), generated from the manifest.

## Pattern A: who orchestrates, who executes

- **LangGraph orchestrates.** The graph in [`orchestration/`](../../orchestration/) decides what to do next, when to loop, when to gate.
- **Claude Code executes.** Each layer's work is performed by a skill in [`.claude/skills/layer-XX-{slug}/SKILL.md`](../../.claude/skills/), invoked by the LangGraph node via the Claude Agent SDK.
- Deterministic gates — entry, exit, HITL, supersede — belong in **nodes** ([`orchestration/nodes/`](../../orchestration/nodes/)), not in skill bodies.

## When no capability matches

Escalate via the [ambiguity protocol](ambiguity-protocol.md). Do not improvise a tool choice. Adding a new capability is a deliberate change to `bindings.yaml`; it lives under lock-once and triggers `00-bootstrap` to converge the install.

## Forbidden moves

- Hand-editing the README's Standard Platform table. It is regenerated from `bindings.yaml` by [`scripts/generate-readme.ps1`](../../scripts/generate-readme.ps1).
- Using a tool not present in `bindings.yaml`. If you reach for one, that's a binding-manifest change, not an inline call.
- Inventing version numbers. Versions are explicit pins; floating ranges (`latest`, `^x`, `*`) are not allowed for Standard Platform Keys.
