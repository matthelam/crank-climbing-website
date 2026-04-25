# Layer 11 — Pull Request

**Status:** active.

**Purpose.** Open a pull request with title, summary, dual-AC checklist, and references to the originating Stories/Features. CI runs against it.

**Position.** Layer 11. Predecessor: `10-local-verification`. Successor: `12-dual-ac-verification`.

## Inputs

- Verification report from `10`.
- Story/Task artifacts touched by the work.

## Outputs

- A GitHub PR (URL recorded).
- `intent/pull-requests/{slug}-{timestamp}.md` — PR record: number, URL, listed Stories, dual-AC stub.

## Bindings used

- `source_hosting` (gh CLI)
- `ci`

## Gates

- **Entry:** verification report all-pass; current branch tracks origin or is pushable.
- **Exit:** PR created; CI started.

## HITL policy

`optional`.

## Loop edges

- `retry_within_step`: gh_create_failed → diagnose and retry (max 2).
- `re_enter_phase`: ci_red → re-enter `09` with CI output as new red feedback.

## Skill

[`/layer-11-pull-request`](../../.claude/skills/layer-11-pull-request/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_11_pull_request.py`](../../orchestration/graphs/layer_11_pull_request.py)
