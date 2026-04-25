---
name: layer-02-brand-kit
description: Synthesize palette, typography, motion, and copy voice (layer 02). Invoked by orchestration/graphs/layer_02_brand_kit.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 02 — Brand Kit

Synthesize a brand kit from the business decomposition. Output is the constraint feed for the UX layer.

**Contract:** [`layers/02-brand-kit/layer.md`](../../../layers/02-brand-kit/layer.md). **Schema:** [`layers/02-brand-kit/schema.output.json`](../../../layers/02-brand-kit/schema.output.json).

## Steps

1. Read the upstream decomposition artifact named in `upstream_refs`. Confirm `body.tone` is present.
2. Read any uploaded brand assets in `overrides` (logo path, palette refs, photography refs).
3. Synthesize:
   - **Palette** — 5-7 colors as W3C Design Tokens (`color-primary`, `color-accent`, `color-bg`, `color-fg`, `color-muted`, `color-success`, `color-danger`).
   - **Typography** — heading + body face from Google Fonts, with type scale (`font-size-xs` through `font-size-3xl`) and line-heights.
   - **Motion** — 3-4 named tokens (`motion-quick`, `motion-standard`, `motion-emphatic`) with durations + easings.
   - **Copy voice** — 5-10 do/don't examples reflecting the decomposition's tone register.
   - **Photography direction** — 2-3 sentence guideline + 3-5 reference URLs.
4. Write two artifacts:
   - `intent/brand-kits/{slug}-{ISO-timestamp}.md` — human-readable kit.
   - `intent/brand-kits/{slug}-{ISO-timestamp}.tokens.json` — W3C Design Tokens.
5. Reply with the markdown artifact path on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| Decomposition tone empty | Abort; bootstrap or decomposition layer was skipped. |
| Tokens schema invalid | Regenerate with W3C Design Tokens schema as inline feedback. |
| Selected font lacks Latin Extended | Pick sibling face from same family; do not silently substitute. |

## Lock-once

Never edit a prior brand kit. Revisions produce a new file with `supersedes` set to the prior `artifact_id`.
