---
name: layer-04-scope
description: Lock the scope document for this rebuild (layer 04). Invoked by orchestration/graphs/layer_04_scope.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 04 — Scope

Lock the scope document for this rebuild — what is in, deferred, or out, with rationale.

**Contract:** [`layers/04-scope/layer.md`](../../../layers/04-scope/layer.md). **Schema:** [`layers/04-scope/schema.output.json`](../../../layers/04-scope/schema.output.json).

## Steps

1. Read decomposition (`01`), brand kit (`02`), UX (`03`).
2. For every business function in the decomposition, classify into exactly one of:
   - `in` — included in this rebuild slice.
   - `deferred` — explicitly out for this slice, planned for a later one.
   - `out` — not in scope at all.
3. For each classification, write a 1-2 sentence rationale.
4. Cross-check: every UX screen must trace to at least one `in` function. Surface orphans.
5. Write `intent/scope/{slug}-{ISO-timestamp}.md`.
6. Reply with the path on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| Scope produces zero `in` items | Abort; nothing to build. |
| UX screen orphaned | Either move the function to `in` or drop the screen. Do not silently leave orphans. |

## Lock-once

Never edit a prior scope. Revisions produce a new file with `supersedes` set to the prior `artifact_id`.
