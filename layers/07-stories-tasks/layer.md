# Layer 07 — Stories + Tasks

**Status:** active.

**Purpose.** Decompose Features into component-shaped Stories (Storybook-testable) and the Tasks that implement them. Stories may declare dependencies on other Stories.

**Position.** Layer 07. Predecessor: `06-requirements`. Successor: `08-red-tests`.

## Inputs

- Feature artifacts from `06`.
- UX (`03`) and brand kit (`02`) for shape and constraint.

## Outputs

- `intent/stories/{slug}-{timestamp}.md` — one Story per component (validates against [`intent/schemas/story.schema.json`](../../intent/schemas/story.schema.json)).
- `intent/tasks/{slug}-{timestamp}.md` — one Task per executable unit (validates against [`intent/schemas/task.schema.json`](../../intent/schemas/task.schema.json)).

## Bindings used

- `agent_runtime`
- `agent_sdk`
- `mcp_storybook`

## Gates

- **Entry:** at least one Feature artifact valid.
- **Exit:** every Feature is decomposed; every Story has at least one Task; dependency graph is acyclic.

## HITL policy

`optional`.

## Loop edges

- `retry_within_step`: cycle_detected → re-decompose.
- `re_enter_step`: hitl_supersede.
- `re_enter_phase`: feature superseded.

## Skill

[`/layer-07-stories-tasks`](../../.claude/skills/layer-07-stories-tasks/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_07_stories_tasks.py`](../../orchestration/graphs/layer_07_stories_tasks.py)
