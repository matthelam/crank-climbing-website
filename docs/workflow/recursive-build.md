# Stage 7: Recursive Build

**Status: *[TBD]*** — scaffolding only.

Detail page for the Workflow **Recursive Build** row — Signal: "Test exists and fails; named artifact absent or incomplete".

## Planned contents

- Implementing the smallest unit that turns the red test green.
- Recursion rule: every composed unit is built from already-tested smaller units.
- Refactor only under a green test; never refactor under a red test.
- Exit condition: all tests green — advance to [Stage 8: Local Verification](local-verification.md).

This document will elaborate the above into a concrete protocol. Until then, apply the spirit: red → green → refactor, applied recursively — no unit is built whose dependencies are not themselves under test.
