# Layer 04 — Scope

**Status:** active.

**Purpose.** Lock the scope document for this rebuild — what's in, what's deferred, what's explicitly out. Replaces speculative planning with a committed decision artifact.

**Position.** Layer 04. Predecessor: `03-ux`. Successor: `05-elaboration`.

## Inputs

- Decomposition (`01`), brand kit (`02`), UX (`03`).

## Outputs

- `intent/scope/{slug}-{timestamp}.md` — scope: in / deferred / out, with rationale per item.

## Bindings used

- `agent_runtime`
- `agent_sdk`

## Gates

- **Entry:** UX artifact present.
- **Exit:** scope artifact validates; every business function present in decomposition appears in exactly one of {in, deferred, out}.

## HITL policy

`optional`.

## Loop edges

- `retry_within_step`: coverage_gap.
- `re_enter_step`: hitl_supersede.
- `re_enter_phase`: any of `01`/`02`/`03` superseded.

## Skill

[`/layer-04-scope`](../../.claude/skills/layer-04-scope/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_04_scope.py`](../../orchestration/graphs/layer_04_scope.py)
