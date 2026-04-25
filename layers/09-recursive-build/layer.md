# Layer 09 — Recursive Build

**Status:** active.

**Purpose.** Make red tests green by implementing leaf-most missing artifacts first, then composing upward. The TDD green and refactor phases, applied recursively. This is the densest loop in the orchestration graph.

**Position.** Layer 09. Predecessor: `08-red-tests`. Successor: `10-local-verification`.

## Inputs

- Failing test files + red-test-runs record from `08`.
- Story + Task artifacts from `07`.
- Brand kit tokens from `02` (for component implementations).

## Outputs

- Implementation files under [`src/`](../../src/).
- `intent/build-runs/{slug}-{timestamp}.md` — per-Story implementation log: which tests went green, which Tasks completed, supersedes recorded.

## Bindings used

- `app_routing`
- `typed_code`
- `styling`
- `primitives`
- `component_lab`
- `unit_test`
- `e2e_test`
- `agent_runtime`
- `agent_sdk`

## Gates

- **Entry:** at least one red test fails.
- **Exit:** all red tests authored in `08` pass; no pre-existing tests regressed.

## HITL policy

`optional`.

## Loop edges

- `retry_within_step`: test_still_red → re-implement with failure feedback (the canonical TDD intra-step loop, max 5 attempts per test).
- `re_enter_step`: refactor_required → green-but-needs-cleanup transitions to the refactor sub-step.
- `re_enter_phase`: red_tests superseded.

## Skill

[`/layer-09-recursive-build`](../../.claude/skills/layer-09-recursive-build/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_09_recursive_build.py`](../../orchestration/graphs/layer_09_recursive_build.py) — note: this subgraph contains a nested LangGraph subgraph for the test-by-test inner loop.
