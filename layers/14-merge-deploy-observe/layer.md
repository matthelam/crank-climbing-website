# Layer 14 — Merge + Deploy + Observe

**Status:** active.

**Purpose.** Merge the approved PR, trigger deployment to Vercel, resume observability. Closes the rebuild loop for the Stories in this PR.

**Position.** Layer 14. Predecessor: `13-review`. Successor: end of main flow (or back to `01` for the next slice; `M` runs on schedule independently).

## Inputs

- Approved PR.

## Outputs

- A merged commit on the default branch.
- A successful Vercel deployment (URL recorded).
- `intent/deployments/{slug}-{timestamp}.md` — deployment record: commit SHA, deploy URL, observability dashboard links, any post-deploy smoke results.

## Bindings used

- `source_hosting`
- `hosting`
- `analytics`
- `observability`

## Gates

- **Entry:** PR approved per `13`.
- **Exit:** merge succeeded, deployment health-check green, observability resumed.

## HITL policy

`required` — deploys are notable events; a human acknowledges go-live.

## Loop edges

- `retry_within_step`: deploy_failed → diagnose and retry.
- `re_enter_phase`: smoke_failed → roll back, re-enter `09` with smoke output as new red test.

## Skill

[`/layer-14-merge-deploy-observe`](../../.claude/skills/layer-14-merge-deploy-observe/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_14_merge_deploy_observe.py`](../../orchestration/graphs/layer_14_merge_deploy_observe.py)
