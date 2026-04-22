# Stage 8: Local Verification

Detail page for the Workflow **Local Verification** row — Signal: "All tests green; type-check / lint / build not run clean".

## Purpose

Local Verification catches what the test runner does not. Tests assert behavior; **type-check** asserts contracts between units; **lint** asserts style and a class of bug patterns; **build** asserts that the whole thing can be packaged and shipped. A Story can be green on tests and still be broken at any of the other three gates.

This stage exists because CI should never be the first place a type error, lint violation, or build failure surfaces. If the author saw it first, they fix it before opening the PR. If CI sees it first, reviewers and pipelines pay the cost, and the feedback loop is measured in minutes instead of seconds.

## Enter / Exit

- **Enter when:** All tests green; type-check, lint, or build has not been run clean locally.
- **Exit when:** Every local gate runs clean — tests green, type-check clean, lint clean, build succeeds.

## Rule

Do not open a PR without a clean local pass of tests, type-check, lint, and build. Any gate that is red locally is a red gate waiting to surface in CI; fix it before the handoff.

## Artifact produced

No new artifact — but a guarantee that CI will not surface a preventable failure.

## Suggested ordering (fail-fast)

1. Tests (should already be green at entry; rerun as sanity).
2. Type-check.
3. Lint.
4. Build.

Earlier gates are faster and catch cheaper classes of error; later gates are slower and catch shipping-time failures. Ordering fail-fast minimizes iteration time.


## Agent protocol

1. Run the test suite. Confirm green.
2. Run type-check. Confirm zero errors.
3. Run lint. Confirm zero errors.
4. Run build. Confirm success.
5. If any gate fails, return to [Stage 7](recursive-build.md) with the gate failure as the new Red signal.
6. Only when every gate is clean, advance to [Stage 9: Pull Request](pull-request.md).
