# Layer 06 — Requirements

**Status:** active.

**Purpose.** Author requirements with goal-level acceptance criteria. Each requirement traces to one business function and feeds the Stories+Tasks decomposition.

**Position.** Layer 06. Predecessor: `05-elaboration`. Successor: `07-stories-tasks`.

## Inputs

- Elaboration (`05`), scope (`04`), decomposition (`01`).

## Outputs

- `intent/features/{slug}-{timestamp}.md` — one Feature artifact per business function in scope, each carrying goal-level AC. Feature schema lives at [`intent/schemas/feature.schema.json`](../../intent/schemas/feature.schema.json).

## Bindings used

- `agent_runtime`
- `agent_sdk`

## Gates

- **Entry:** elaboration valid.
- **Exit:** every in-scope business function has a Feature artifact; each artifact validates against the Feature schema; each AC is goal-level (not implementation-level).

## HITL policy

`optional`.

## Loop edges

- `retry_within_step`: ac_not_goal_level.
- `re_enter_step`: hitl_supersede.
- `re_enter_phase`: elaboration or scope superseded.

## Skill

[`/layer-06-requirements`](../../.claude/skills/layer-06-requirements/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_06_requirements.py`](../../orchestration/graphs/layer_06_requirements.py)
