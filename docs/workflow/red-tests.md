# Stage 6: Red Tests

**Status: *[TBD]*** — scaffolding only.

Detail page for the Workflow **Red Tests** row — Signal: "Story exists; its named test file absent".

## Planned contents

- Deterministic test-file naming derived from the Story identifier.
- Writing a failing test that asserts the Story's technical AC — no implementation yet.
- Test type routing: Vitest for non-UI logic, Playwright for end-to-end UI behaviour.
- Exit condition: a named test file exists and fails — advance to [Stage 7: Recursive Build](recursive-build.md).

This document will elaborate the above into a concrete protocol. Until then, apply the spirit: the red test is the first authored artifact for any Story — if it passes immediately or does not run, the Story is not ready to build.
