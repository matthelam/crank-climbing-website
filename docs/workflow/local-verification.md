# Stage 8: Local Verification

**Status: *[TBD]*** — scaffolding only.

Detail page for the Workflow **Local Verification** row — Signal: "All tests green; type-check / lint / build not run clean".

## Planned contents

- Running type-check, lint, and build locally before opening a PR.
- Ordering: tests first (already green at entry), then type-check, then lint, then build.
- What counts as "clean" — zero errors across every gate, not just the test runner.
- Exit condition: every local gate clean — advance to [Stage 9: Pull Request](pull-request.md).

This document will elaborate the above into a concrete protocol. Until then, apply the spirit: CI is not the first place type errors, lint violations, or build failures should surface.
