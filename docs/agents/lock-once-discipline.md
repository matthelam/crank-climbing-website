# Lock-once discipline

Outputs of every layer are immutable once committed. Revisions produce new artifacts; they do not edit prior ones.

## The rule

For any file under [`intent/`](../../intent/):

- **Never edit it after the producing commit lands.**
- To revise, write a **new** file with `supersedes` set to the prior `artifact_id`.
- The prior file stays in place forever — it is the audit trail.

This applies equally to bootstrap reports, decompositions, brand kits, scope documents, requirements, stories, tasks, test runs, build runs, verifications, reviews, deployments, and maintenance reports.

## Why

The layered model only works if each layer's output is a stable foundation for the next. If layer N's output mutates after layer N+1 consumed it, the entire downstream chain becomes unsafe. Lock-once makes recursion correct — the orchestrator can re-enter a phase confident that the artifact it sees on disk is the exact artifact that was produced.

## Mechanism

Every output schema requires:

```jsonc
{
  "artifact_id": "slug-2026-04-25T120000Z",     // includes timestamp; never reused
  "produced_at": "2026-04-25T12:00:00Z",        // matches artifact_id timestamp
  "supersedes": null                            // or the artifact_id of the prior locked artifact
}
```

The orchestration node `write_artifact_supersede` (in [`orchestration/nodes/supersede.py`](../../orchestration/nodes/supersede.py)) records the supersede relationship in state; the skill writes the new file.

## What violates the discipline

- Editing a file under `intent/` to fix a typo. (Write a new artifact instead.)
- Reusing an `artifact_id` for two different files.
- Deleting a prior artifact when its supersede lands. (The prior remains as audit.)
- Mutating `bindings.yaml` in place when bumping a version. (Use the maintenance layer's `bindings.yaml.proposal` mechanism.)

## What does NOT count as a locked artifact

- Files under [`src/`](../../src/), [`docs/`](../../docs/), [`layers/`](../../layers/), [`orchestration/`](../../orchestration/), [`infrastructure/`](../../infrastructure/), or [`scripts/`](../../scripts/) — these are scaffold or application code, not intent artifacts.
- Files under [`.claude/`](../../.claude/) — these are agent configuration, not intent artifacts. They follow normal version-control discipline.

## Maintenance layer interaction

The maintenance layer (`M-maintenance`) honours lock-once: it never mutates `bindings.yaml` directly. It produces a `bindings.yaml.proposal` and opens a PR. Human merge is the convergence event.

## See also

- [`ambiguity-protocol.md`](ambiguity-protocol.md) — what to do *instead* of editing.
- [Layer 12 — Dual-AC Verification](../../layers/12-dual-ac-verification/layer.md) — the verification layer cites both AC and produces supersede chains when failures are found.
