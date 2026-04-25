---
name: layer-08-red-tests
description: Author failing tests before any implementation (layer 08). Invoked by orchestration/graphs/layer_08_red_tests.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 08 — Red Tests

Author failing tests for every Story and Task before any implementation. The TDD red phase, applied recursively.

**Contract:** [`layers/08-red-tests/layer.md`](../../../layers/08-red-tests/layer.md). **Schema:** [`layers/08-red-tests/schema.output.json`](../../../layers/08-red-tests/schema.output.json).

## Steps

1. Read Stories + Tasks from `07`.
2. For each Story, author the named test files specified in its Tasks:
   - Component (Storybook interaction): `src/{path}/{Component}.stories.tsx`.
   - Unit (Vitest): `src/{path}/{module}.test.ts`.
   - E2E (Playwright): `e2e/{feature}/{story}.spec.ts`.
3. Run the full test suite once. Confirm:
   - Newly-authored tests fail with **assertion** errors (not import errors).
   - No previously-passing test now fails.
4. Write `intent/red-test-runs/{slug}-{ISO-timestamp}.md` with the per-Story test file map and failure summary.
5. Reply with the red-test-run path on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| New test fails with import error, not assertion | Refactor so test imports cleanly but fails on intent (e.g., assert against an `undefined` placeholder). |
| Pre-existing test now fails | Revert; the new test scope is too broad. |

## Lock-once

The red-test-run record is lock-once. Test files themselves under `src/` and `e2e/` are application code, not intent — they evolve normally.
