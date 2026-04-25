---
name: layer-06-requirements
description: Author requirements with goal-level acceptance criteria (layer 06). Invoked by orchestration/graphs/layer_06_requirements.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 06 — Requirements

Author Feature artifacts with goal-level acceptance criteria. One Feature per `in` business function.

**Contract:** [`layers/06-requirements/layer.md`](../../../layers/06-requirements/layer.md). **Schema:** [`layers/06-requirements/schema.output.json`](../../../layers/06-requirements/schema.output.json).

## Steps

1. Read elaboration (`05`), scope (`04`), decomposition (`01`).
2. For every `in` business function, draft a Feature:
   - `feature_id` (kebab-case, stable).
   - `name`.
   - `business_function_ref` — id from decomposition.
   - `goal_acceptance_criteria` — 3-5 outcome-level AC. **Goal-level** = observable from a user perspective, not "API returns 200" but "user sees their booking confirmed within 3s."
   - `playwright_test_hint` — one-sentence sketch of the e2e test that would prove the AC.
3. Validate each Feature against [`intent/schemas/feature.schema.json`](../../../intent/schemas/feature.schema.json) when present.
4. Write one file per Feature: `intent/features/{feature_id}-{ISO-timestamp}.md`.
5. Reply with a JSON array of new artifact paths on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| AC slips into implementation language | Rewrite at goal-level; "user sees X" not "endpoint returns Y". |
| Feature schema absent | Fall back to layer's schema.output.json; flag missing schema as TODO. |

## Lock-once

Each Feature is a new file. Revisions produce a new file with `supersedes` set.
