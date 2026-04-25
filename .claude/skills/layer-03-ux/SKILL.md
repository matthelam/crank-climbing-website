---
name: layer-03-ux
description: Generate UX stories and screen-level designs (layer 03). Invoked by orchestration/graphs/layer_03_ux.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 03 — UX

Generate UX stories and screen-level designs that satisfy the business decomposition under brand-kit constraints.

**Contract:** [`layers/03-ux/layer.md`](../../../layers/03-ux/layer.md). **Schema:** [`layers/03-ux/schema.output.json`](../../../layers/03-ux/schema.output.json).

## Steps

1. Read decomposition (`01`) and brand kit (`02`) from `upstream_refs`.
2. For each business function in the decomposition, draft a user journey: trigger → screens → exit conditions. Minimum 1 journey per function.
3. Compile a screen list — every distinct screen across journeys, deduplicated.
4. For each screen, produce a structured description: purpose, primary content, primary action, brand-kit tokens consumed.
5. If `overrides.ux_tool == "claude.ai/design"`, include a prompt block per screen suitable for pasting in.
6. If `overrides.ux_tool == "v0"`, include a prompt block per screen suitable for v0.dev.
7. Write:
   - `intent/ux/{slug}-{ISO-timestamp}.md` — UX intent (journeys + screen list).
   - `intent/ux/{slug}-{ISO-timestamp}.frames.md` — screen-level descriptions.
8. Reply with the journeys file path on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| Brand kit tokens insufficient for a screen | Flag the gap; brand kit may need supersede. Do not invent tokens. |
| Two journeys cover the same screen with conflicting content | Pick the journey with the higher-tier business function (Conversion > Consideration > Retention); flag in evidence_refs. |

## Lock-once

Never edit a prior UX artifact. Revisions produce a new file with `supersedes` set to the prior `artifact_id`.
