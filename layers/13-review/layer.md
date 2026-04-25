# Layer 13 — Review

**Status:** active.

**Purpose.** Code review and approval of the PR. Reviewers may request changes (re-enter `09`) or approve.

**Position.** Layer 13. Predecessor: `12-dual-ac-verification`. Successor: `14-merge-deploy-observe`.

## Inputs

- PR with dual-AC verification recorded.

## Outputs

- PR review record (approval or change-requests).
- `intent/reviews/{slug}-{timestamp}.md` — review notes summary.

## Bindings used

- `source_hosting`
- `agent_runtime`
- `agent_sdk`

## Gates

- **Entry:** dual-AC verification recorded.
- **Exit:** at least one approving review (count from `infrastructure/github/repo.yaml` branch_protection); no outstanding change requests.

## HITL policy

`required` — code review is human approval by definition.

## Loop edges

- `re_enter_phase`: changes_requested → re-enter `09` (or earlier if the request invalidates a Story).

## Skill

[`/layer-13-review`](../../.claude/skills/layer-13-review/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_13_review.py`](../../orchestration/graphs/layer_13_review.py)
