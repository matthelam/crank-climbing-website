---
name: layer-13-review
description: Code review and approval of the PR (layer 13). Invoked by orchestration/graphs/layer_13_review.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 13 — Review

Code review and approval of the PR. Required HITL.

**Contract:** [`layers/13-review/layer.md`](../../../layers/13-review/layer.md). **Schema:** [`layers/13-review/schema.output.json`](../../../layers/13-review/schema.output.json).

## Steps

1. Read PR record from `11` and dual-AC verification from `12`.
2. Use the `engineering:code-review` skill (or post review comments via `gh pr review`) to inspect the diff against:
   - Lock-once compliance (no edits to `intent/` files).
   - Brand-kit token usage (no hard-coded colors / fonts that bypass tokens).
   - Schema validation (every artifact validates).
3. Decide: approve, request changes, or comment.
4. If approve: `gh pr review --approve`.
5. If request changes: `gh pr review --request-changes -b "<reasons>"` — orchestrator routes via `re_enter_phase` back to layer 09.
6. Write `intent/reviews/{pr-number}-{ISO-timestamp}.md` summarising review notes.
7. Reply with the review record path on the final line.

## HITL

`required` — code review is human approval. Even if automated review precedes, the human must explicitly approve.

## Failure modes

| Failure | Recovery |
|---|---|
| Diff includes a changed file under `intent/` | Reject; lock-once violation. |
| Review reaches no consensus across multiple reviewers | Default to `request changes`, surface to HITL. |

## Lock-once

The review record is lock-once.
