# Stage 10: Dual-AC Verification

Detail page for the Workflow **Dual-AC Verification** row — Signal: "PR open with green CI; no verification notes referencing both AC".

## Purpose

Dual-AC Verification is where the PR is checked against **both** acceptance criteria families:

- **Technical AC** (from the Story): asserted by tests in CI. Green CI proves technical AC.
- **Goal-level AC** (from the Requirement): the user-facing outcome. CI does not prove goal-level AC — it can only prove that the units under test behave as tested.

A PR that skips this stage can ship code that passes every test and still fails to solve the problem. The purpose here is to close that gap: exercise the running system (Preview deployment) against the goal-level outcome and record explicit evidence on the PR.

For UI changes, the running system is the Vercel Preview; verification happens in the browser (Chrome DevTools MCP, Playwright MCP). For non-UI changes, verification happens via integration paths (scripts, API calls) against the Preview or an integration environment.

## Enter / Exit

- **Enter when:** PR is open with green CI; no verification notes exist on the PR that reference both the goal-level AC and the technical AC.
- **Exit when:** Verification notes exist on the PR that explicitly reference both the goal-level AC and the technical AC, each with evidence.

## Rule

CI green is a precondition for verification, not verification itself. Every PR carries explicit notes proving both AC are satisfied against a running system — goal-level AC exercised end-to-end, technical AC cited to the tests that assert it.

## Artifact produced

Verification notes on the PR (description or dedicated comment) with evidence for goal-level and technical AC.

## Verification evidence shape (suggested)

- **Technical AC:** link to the test file(s); link to the CI run that passed.
- **Goal-level AC:** describe the exercise performed against the Preview (or integration environment); link to a recording, screenshot, log snippet, or analytics event that proves the outcome.


## Agent protocol

1. Read the PR, Story, and Requirement.
2. For technical AC: confirm CI is green and that the named tests assert the AC cited in the PR body.
3. For goal-level AC: exercise the Preview against the user-facing outcome. Use Chrome DevTools MCP or Playwright MCP for UI; use integration scripts for non-UI.
4. Tail runtime logs (Vercel runtime observability) during verification to catch silent failures.
5. For analytics-bound AC, fire the expected interaction and confirm the event in Vercel Analytics.
6. Author verification notes on the PR referencing both AC and citing the evidence.
7. Advance to [Stage 11: Review](review.md).
