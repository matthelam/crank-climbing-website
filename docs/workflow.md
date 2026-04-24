# Workflow

Twelve stages, walked top-down. The first signal that fires is the current stage. Walk up the chain when the stage you're on lacks an upstream artifact.

## 1 — Scope

- **Enter:** No Scope document exists.
- **Exit:** Scope document captures problem, audience, and what the change is *not*.
- **Rule:** Scope answers "why are we doing this?" Lock-once on commit.

## 2 — Elaboration

- **Enter:** Scope exists; no Elaboration.
- **Exit:** Elaboration expands Scope into stakeholders, constraints, and success signals.
- **Rule:** Elaboration is where ambiguity surfaces — name what you don't yet know.

## 3 — Requirements

- **Enter:** Elaboration exists; no Requirement with goal-level AC.
- **Exit:** Requirements carry goal-level AC — outcome-shaped, end-to-end testable.
- **Rule:** Goal-level AC is what Playwright will assert at Stage 10. If you can't write it as a `Given/When/Then`, the requirement is not ready.

## 4 — UI/UX (conditional)

- **Enter:** Requirement needs UI; no design Story or Figma source.
- **Exit:** Design Story exists in Figma, linked to the Requirement.
- **Rule:** Design source of truth is Figma. The Insights layer constrains; Figma is the generative surface.

## 5 — Stories + Tasks

- **Enter:** Requirement exists; no decomposed Stories with technical AC.
- **Exit:** Stories exist with technical AC, each linked to parent Requirement and parent Feature; Tasks decompose each Story; Story type and dependencies declared.
- **Rule:** Story = component (Storybook-testable). Page-assembly Story declares dependencies on its Component Stories. Feature = business process (Playwright-tested). Lock-once on commit.

## 6 — Red Tests

- **Enter:** Story exists; named test file absent.
- **Exit:** Failing test at deterministic path; fails for the right reason (missing code, not infrastructure).
- **Rule:** Red Test first. Routed by Story type — Component Story → Storybook `.stories.tsx` with failing `play`; Feature → Playwright `.spec.ts`; Non-UI Task → Vitest `.test.ts`.

## 7 — Recursive Build

- **Enter:** Red Test fails; named artifact absent or incomplete.
- **Exit:** All tests green — Red Test plus every test covering composed sub-units.
- **Rule:** Red → Green → Refactor, applied recursively. Never compose an untested unit into a tested one. **Storybook-green precedes Playwright-green; never the reverse.**

## 8 — Local Verification

- **Enter:** Tests green; type-check / lint / build not run clean locally.
- **Exit:** All four gates clean — tests, type-check, lint, build.
- **Rule:** CI is never the first place a preventable failure surfaces. Run gates fail-fast: tests → type-check → lint → build.

## 9 — Pull Request

- **Enter:** Local clean; no PR open.
- **Exit:** PR open, CI green, body links to Story and names the AC each test asserts. Vercel Preview deployed.
- **Rule:** Every PR links to its Story. Every PR names the technical AC it satisfies and cites the test files. CI green is a precondition for handoff to Stage 10.

## 10 — Dual-AC Verification

- **Enter:** PR open with green CI; no verification notes referencing both AC.
- **Exit:** PR carries notes proving both technical AC (CI tests) and goal-level AC (running Preview, exercised end-to-end) with cited evidence.
- **Rule:** CI green is a precondition for verification, not verification itself. Goal-level AC requires running the Preview against the user-facing outcome (Chrome DevTools MCP / Playwright MCP for UI; integration scripts for non-UI). Tail Vercel runtime logs.

## 11 — Review

- **Enter:** Verification notes exist; PR not approved.
- **Exit:** Approved against Business Principles, Technology Principles, and Engineering Practices.
- **Rule:** Review answers what automated gates cannot — is this the right change? Modifications loop back to Stage 7 or 8; never rewrite the PR under an open approval.

## 12 — Merge + Deploy + Observe

- **Enter:** Approved; not merged, or observability not resumed.
- **Exit:** Merged to `main`; Vercel deployed to Production; observability under active watch (logs, analytics, errors, Core Web Vitals) for 15–60 minutes (longer for high-risk changes).
- **Rule:** Merge is not the exit — observability resumption is. If signals regress in the watch window, open a superseding PR. Lock-once applies post-merge as well.
