# Layer 08 — Red Tests

**Status:** active.

**Purpose.** Author failing tests for every Story and Task before any implementation begins. The TDD red phase, applied recursively.

**Position.** Layer 08. Predecessor: `07-stories-tasks`. Successor: `09-recursive-build`.

## Inputs

- Story + Task artifacts from `07`.

## Outputs

- Test files in `src/**/*.test.ts`, `src/**/*.spec.ts`, `e2e/**/*.spec.ts`, `*.stories.tsx` interaction tests, etc.
- `intent/red-test-runs/{slug}-{timestamp}.md` — record of which tests were authored, which run red, and the per-Story coverage map.

## Bindings used

- `unit_test`
- `e2e_test`
- `component_lab`
- `agent_runtime`
- `agent_sdk`

## Gates

- **Entry:** Stories + Tasks valid.
- **Exit:** every Story has at least one named test file; running the full test suite produces failures only for the newly-authored tests (no regressions in pre-existing passing tests).

## HITL policy

`optional`.

## Loop edges

- `retry_within_step`: pre_existing_test_broken → revert and re-author with finer scope.
- `re_enter_step`: hitl_supersede.
- `re_enter_phase`: stories or tasks superseded.

## Skill

[`/layer-08-red-tests`](../../.claude/skills/layer-08-red-tests/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_08_red_tests.py`](../../orchestration/graphs/layer_08_red_tests.py)
