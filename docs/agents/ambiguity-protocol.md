# Ambiguity protocol

What to do when a requested action does not match any layer's contract, or when the artifact needed to proceed does not exist.

## Walk up the layer chain

If layer N's `gates.yaml` entry condition is "predecessor artifact exists" and that artifact is missing, the session owes **layer N−1**, not layer N. Locate the highest unbuilt layer and report it. The orchestrator's `re_enter_phase` loop edge models this exact case.

## Stop, do not improvise

Never invent an artifact to unblock execution. Invented Stories, Tasks, or Decompositions bypass the layer's contract and leak variance into the lock-once tier. The system's value depends on every artifact being produced by its declared layer.

## Escalate with a specific ask

When reporting ambiguity, name:

- The current layer id.
- Which gate failed (entry / exit / hitl).
- The missing upstream artifact (path or id).
- The layer that owns producing it.
- The human action required to resolve (e.g., "supply `target_url`", "approve the supersede in PR #123").

## Never silently edit a locked artifact

Locked artifacts under `intent/` are immutable. If the right move is to revise one, write a *superseding* artifact (new file with `supersedes` set to the prior id). See [`lock-once-discipline.md`](lock-once-discipline.md).

## Common ambiguity sources

| Signal | Likely cause | Resolution |
|---|---|---|
| "I have no upstream_refs" | The orchestrator started this layer mid-flow without running predecessors. | Stop and report; orchestrator should re-enter from the appropriate predecessor. |
| "The output schema rejects my payload" | The layer's contract was tightened after the skill body was written. | Re-author the skill body to match; do not loosen the schema. |
| "Two upstream artifacts conflict" | Concurrent supersedes upstream. | Pick the one with the latest `produced_at`; record the other in `supersedes` if you're producing a merge. |
| "The bindings manifest names a tool I can't find" | Bootstrap layer hasn't run, or pin drifted. | Re-run `00-bootstrap`. |
