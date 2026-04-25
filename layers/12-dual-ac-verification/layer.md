# Layer 12 — Dual-AC Verification

**Status:** active.

**Purpose.** Verify both story-level technical AC and feature-level goal AC against the running PR. Record verification notes that cite both forms.

**Position.** Layer 12. Predecessor: `11-pull-request`. Successor: `13-review`.

## Inputs

- PR record from `11`.
- Story + Feature artifacts being verified.

## Outputs

- `intent/verifications-dual-ac/{slug}-{timestamp}.md` — dual-AC verification record: per-AC pass/fail, evidence citations (test run ids, screenshots, manual steps), supersedes if any.
- A PR comment with the same content posted via `gh`.

## Bindings used

- `source_hosting`
- `e2e_test`
- `mcp_chrome_devtools` (manual evidence capture)
- `mcp_playwright`
- `agent_runtime`
- `agent_sdk`

## Gates

- **Entry:** PR has green CI.
- **Exit:** every Story-AC and every Feature-AC explicitly cited as pass or fail; failures produce supersedes back into `09`.

## HITL policy

`required` — verification is the load-bearing checkpoint; a human signs off here.

## Loop edges

- `re_enter_phase`: any AC fails → supersede the affected Story/Feature, re-enter from the appropriate predecessor layer.

## Skill

[`/layer-12-dual-ac-verification`](../../.claude/skills/layer-12-dual-ac-verification/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_12_dual_ac_verification.py`](../../orchestration/graphs/layer_12_dual_ac_verification.py)
