# Layer 05 — Elaboration

**Status:** active.

**Purpose.** Risk-driven analysis of the locked scope — surface integrations, complexities, architectural decisions, sequencing constraints. Produces the input that Requirements consumes.

**Position.** Layer 05. Predecessor: `04-scope`. Successor: `06-requirements`.

## Inputs

- Scope artifact from `04`.

## Outputs

- `intent/elaborations/{slug}-{timestamp}.md` — elaboration: risks, integrations, ADR-shaped architectural calls, sequencing notes.

## Bindings used

- `agent_runtime`
- `agent_sdk`
- `mcp_nextjs_devtools`
- `mcp_microsoft_docs`

## Gates

- **Entry:** scope artifact valid.
- **Exit:** elaboration validates; every architectural call cites at least one upstream doc lookup.

## HITL policy

`optional`.

## Loop edges

- `retry_within_step`: missing_citation.
- `re_enter_step`: hitl_supersede.
- `re_enter_phase`: scope superseded.

## Skill

[`/layer-05-elaboration`](../../.claude/skills/layer-05-elaboration/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_05_elaboration.py`](../../orchestration/graphs/layer_05_elaboration.py)
