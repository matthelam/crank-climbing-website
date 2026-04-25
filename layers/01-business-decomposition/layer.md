# Layer 01 — Business Decomposition

**Status:** active. Skill body and output schema fully specified.

**Purpose.** Decompile the target business into its functions across the three Business Principles tiers (Conversion, Consideration, Retention). Output is a structured map that constrains every downstream layer.

**Position.** Layer 01. Predecessor: `00-bootstrap`. Successor: `02-brand-kit`.

## Inputs

- `target_url` — live URL of the existing site (extracted via `page_extraction` capability / Defuddle).
- `manual_brief` (optional) — human-supplied overrides or augmentations layered on top of URL extraction.

## Outputs

- `intent/decompositions/{slug}-{timestamp}.md` — business-function map keyed to the Conversion / Consideration / Retention tiers, plus extracted tone notes and asset references.

## Bindings used

- `page_extraction`
- `agent_runtime`
- `agent_sdk`
- `orchestrator`

## Gates

- **Entry:** bootstrap report committed; `target_url` resolves; `manual_brief` (if supplied) parses.
- **Exit:** decomposition artifact validates against `schema.output.json`; every tier has at least one entry.

## HITL policy

`optional` — decomposition is generative and benefits from a human read, but does not require it.

## Loop edges

- `retry_within_step`: extraction_failed → re-run extraction with adjusted Defuddle settings (max 2 attempts).
- `re_enter_step`: hitl_supersede → human revises; new artifact written, prior id recorded as `supersedes`.

## Skill

[`/layer-01-business-decomposition`](../../.claude/skills/layer-01-business-decomposition/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_01_business_decomposition.py`](../../orchestration/graphs/layer_01_business_decomposition.py)
