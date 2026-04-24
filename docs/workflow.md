# Workflow — Stages 6 to 12

Spec Kit owns Stages 1–5 via [`/speckit.*`](../.claude/commands/) and the constitution at [`.specify/memory/constitution.md`](../.specify/memory/constitution.md). The stages below remain Crank-specific because Spec Kit does not cover Vercel preview verification, dual-AC review, or production observability.

Entry/Exit/Rule per stage. Walk top-down; the first signal that fires is the current stage.

## Stage 6 — Red Tests

- **Enter:** A Story exists; its named test file is absent.
- **Exit:** Failing test exists at the deterministic path for the Story, runs, and fails for the right reason (missing code, not infrastructure).
- **Rule:** Red Test first. Routed by Story type per the constitution test ladder — Component Story → Storybook `.stories.tsx` with failing `play`; Feature → Playwright `.spec.ts`; Non-UI Task → Vitest `.test.ts`.

## Stage 7 — Recursive Build

- **Enter:** Red Test fails; named artifact absent or incomplete.
- **Exit:** All tests green — Red Test plus every test covering composed sub-units.
- **Rule:** Red → Green → Refactor, applied recursively. Never compose an untested unit into a tested one. Storybook-green precedes Playwright-green; never the reverse.

## Stage 8 — Local Verification

- **Enter:** Tests green; type-check / lint / build not run clean locally.
- **Exit:** All four gates clean — tests, type-check, lint, build.
- **Rule:** CI is never the first place a preventable failure surfaces. Run gates fail-fast: tests → type-check → lint → build.

## Stage 9 — Pull Request

- **Enter:** Local clean; no PR open.
- **Exit:** PR open, CI green, body links to spec and names the AC each test asserts. Vercel Preview deployed.
- **Rule:** Every PR links to its spec. Every PR names the technical AC it satisfies and cites the test files. CI green is a precondition for handoff to Stage 10.

## Stage 10 — Dual-AC Verification

- **Enter:** PR open with green CI; no verification notes referencing both AC.
- **Exit:** PR carries explicit notes proving both technical AC (CI tests) and goal-level AC (running Preview, exercised end-to-end) with cited evidence.
- **Rule:** CI green is not verification — it is a precondition for it. Goal-level AC requires running the Preview against the user-facing outcome (Chrome DevTools MCP / Playwright MCP for UI; integration scripts for non-UI). Tail Vercel runtime logs during verification.

## Stage 11 — Review

- **Enter:** Verification notes exist; PR not approved.
- **Exit:** Approved against the constitution and engineering practices.
- **Rule:** Review answers what automated gates cannot — is this the right change? Modifications loop back to Stage 7 or 8; they do not rewrite the PR under an open approval.

## Stage 12 — Merge + Deploy + Observe

- **Enter:** Approved; not merged, or observability not resumed.
- **Exit:** Merged to `main`; Vercel deployed to Production; observability under active watch (logs, analytics, errors, Core Web Vitals) for 15–60 minutes (longer for high-risk changes).
- **Rule:** Merge is not the exit — observability resumption is. If signals regress in the watch window, open a superseding PR. Never edit a merged commit; lock-once applies post-merge as well.
