# Layer 02 — Brand Kit

**Status:** active.

**Purpose.** Synthesize a brand kit — palette, typography, motion, copy voice, photography direction — from the business decomposition. The kit is the constraint feed for the UX layer; UX cannot generate against arbitrary aesthetics, only against this kit.

**Position.** Layer 02. Predecessor: `01-business-decomposition`. Successor: `03-ux`.

## Inputs

- Decomposition artifact from `01-business-decomposition`.
- Optional uploaded brand assets (logo, existing palette, photography references).

## Outputs

- `intent/brand-kits/{slug}-{timestamp}.md` — brand kit document with palette tokens, type scale, motion principles, voice/tone rules, do/don't examples.
- `intent/brand-kits/{slug}-{timestamp}.tokens.json` — design tokens in W3C Design Tokens format for direct consumption by Tailwind config / Storybook.

## Bindings used

- `ux_design` (for AI: Claude.ai/design; for human: Figma)
- `agent_runtime`
- `agent_sdk`

## Gates

- **Entry:** decomposition artifact validates; tone notes present.
- **Exit:** kit + tokens both written; tokens validate against W3C schema.

## HITL policy

`optional`.

## Loop edges

- `retry_within_step`: tokens_invalid → regenerate with schema feedback.
- `re_enter_step`: hitl_supersede.
- `re_enter_phase`: decomposition superseded.

## Skill

[`/layer-02-brand-kit`](../../.claude/skills/layer-02-brand-kit/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_02_brand_kit.py`](../../orchestration/graphs/layer_02_brand_kit.py)
