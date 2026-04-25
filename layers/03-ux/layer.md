# Layer 03 — UX

**Status:** active.

**Purpose.** Generate UX stories and screen-level designs that satisfy the business decomposition under the brand-kit constraints. UX outputs are *intent*, not delivered code; they feed the Stories layer.

**Position.** Layer 03. Predecessor: `02-brand-kit`. Successor: `04-scope`.

## Inputs

- Decomposition artifact from `01`.
- Brand kit + tokens from `02`.
- Optional Figma file ref or Claude.ai/design conversation ref.

## Outputs

- `intent/ux/{slug}-{timestamp}.md` — UX intent: user journeys per business tier, screen list, interaction notes.
- `intent/ux/{slug}-{timestamp}.frames.md` — screen-level descriptions (linkable to Figma frames or v0 generations).

## Bindings used

- `ux_design`
- `ui_generation`
- `agent_runtime`

## Gates

- **Entry:** brand kit + decomposition valid.
- **Exit:** every business-function entry has at least one UX journey reference.

## HITL policy

`optional` — UX is creative output; humans often want eyes here.

## Loop edges

- `retry_within_step`: missing_coverage → regenerate to cover gaps.
- `re_enter_step`: hitl_supersede.
- `re_enter_phase`: brand kit or decomposition superseded.

## Skill

[`/layer-03-ux`](../../.claude/skills/layer-03-ux/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_03_ux.py`](../../orchestration/graphs/layer_03_ux.py)
