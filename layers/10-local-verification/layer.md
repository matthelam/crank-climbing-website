# Layer 10 — Local Verification

**Status:** active.

**Purpose.** Run the deterministic local checks — type-check, lint, full test suite, production build. Cheap to run, cheap to fail-fast.

**Position.** Layer 10. Predecessor: `09-recursive-build`. Successor: `11-pull-request`.

## Inputs

- Working tree after `09` exits.

## Outputs

- `intent/verifications/{slug}-{timestamp}.md` — verification report: each check's status and command output.

## Bindings used

- `type_check`
- `unit_test`
- `e2e_test`
- `app_routing` (production build)

## Gates

- **Entry:** `09` exit gate met (all red tests green).
- **Exit:** all four checks pass.

## HITL policy

`skip` — these are deterministic gates; humans don't add value.

## Loop edges

- `re_enter_phase`: any check fails → re-enter `09` with the failure as a new red test (or as direct feedback if the failure is type/lint).

## Skill

[`/layer-10-local-verification`](../../.claude/skills/layer-10-local-verification/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_10_local_verification.py`](../../orchestration/graphs/layer_10_local_verification.py)
