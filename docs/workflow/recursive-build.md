# Stage 7: Recursive Build

Detail page for the Workflow **Recursive Build** row — Signal: "Test exists and fails; named artifact absent or incomplete".

## Purpose

The Recursive Build implements the smallest unit that turns the Red Test green, then refactors under a green test, then composes the next unit from already-tested sub-units. **Recursive** means every composed unit is built from already-tested smaller units. No unit enters the build whose dependencies are not themselves under test.

This discipline is what makes Stage 10's Dual-AC Verification auditable. If the build respects recursion, each green test proves its unit works, and composed units inherit correctness from composed tests. If the build violates recursion — if it composes untested units — then greenness at the top does not prove correctness underneath, and a later regression cannot be localized.

The recursion follows the test ladder: every Component Story is Storybook-green before it composes into another Story; a Feature's Playwright test runs only after every Story it depends on is green. Storybook-green precedes Playwright-green; never the reverse. A Playwright failure against an unverified component cannot be localized, which defeats the purpose of the ladder.

This is also the stage where the bulk of Standard Platform tools come into play. The Red Test fixed the contract; this stage is where the contract is met.

## Enter / Exit

- **Enter when:** A Red Test exists and fails; the named artifact it asserts against is absent or incomplete.
- **Exit when:** All tests are green — the Red Test for this Story plus every test covering units composed into it — with no new untested dependencies introduced.

## Rule

Red → Green → Refactor, applied recursively. Refactor only under a green test. Never compose an untested unit into a tested one — if a sub-unit needs to exist, it gets its own Red Test first (loop back to [Stage 6](red-tests.md) for that sub-unit).

## Artifact produced

The implementation code that turns the Red Test green, plus any sub-unit tests written along the way.


## Agent protocol

1. Run the Red Test. Confirm it still fails for the right reason.
2. Implement the smallest unit that turns it green.
3. Run the test. Confirm green.
4. Refactor as needed — but only with the test green.
5. If composing a new unit, that sub-unit gets its own Red Test first; loop to [Stage 6](red-tests.md) for it.
6. Continue until all tests — this Story's Red Test and every composed sub-unit's test — are green.
7. Advance to [Stage 8: Local Verification](local-verification.md).
