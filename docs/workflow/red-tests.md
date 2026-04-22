# Stage 6: Red Tests

Detail page for the Workflow **Red Tests** row — Signal: "Story exists; its named test file absent".

## Purpose

A Red Test is the first artifact authored after a Story locks. It is the contract the implementation will be built against. The test file's name and location are deterministic functions of the Story identifier — any agent reading the Story can predict the test file, and any agent reading the test file can find the Story.

The test must fail for the **right reason**: the code under test does not yet exist, or does not yet implement the Story's technical AC. A test that passes immediately is not a Red Test — it is a false signal that the Story is already done. A test that fails on a syntax error or import error is not a Red Test — it is broken infrastructure. Both cases produce misleading green-to-red transitions in Stage 7 and must be caught here.

## Enter / Exit

- **Enter when:** A Story exists; its named test file is absent.
- **Exit when:** A named test file exists at the deterministic path for the Story, runs, and fails because the Story's AC is not yet satisfied.

## Rule

Red Test first. No implementation code is written before the Red Test exists and runs red for the right reason. Tests that pass on first run or fail for infrastructure reasons are treated as broken and fixed here, before Stage 7.

## Artifact produced

A failing test file at the deterministic path derived from the Story identifier.

## Test-type routing

| Test scope | Runner |
|-----------|--------|
| Non-UI logic (unit, integration) | [Vitest](../technology/vitest.md) |
| End-to-end user-facing behavior | [Playwright](../technology/playwright.md) |
| Component (presentation) | Vitest + a testing library until the project adopts a component-E2E convention |

## Standard Platform tools

| Tool | When to reach for it at this stage |
|------|------------------------------------|
| [Vitest](../technology/vitest.md) | Primary runner for non-UI logic; watch mode while drafting the test. |
| [Playwright](../technology/playwright.md) | Primary runner for end-to-end user-facing AC. |
| [Playwright MCP](../technology/playwright-mcp.md) | Script the browser interaction the E2E test will assert against; use the accessibility snapshot to target stable roles rather than brittle selectors. |
| [TypeScript](../technology/typescript.md) | Test files are TypeScript; types are part of the AC. |
| [Next.js DevTools MCP](../technology/next-js-devtools-mcp.md) | Ground test assumptions about framework behavior (routing, data fetching, caching). |
| [Chrome DevTools MCP](../technology/chrome-devtools-mcp.md) | Inspect the page state a Playwright test should assert against before writing selectors. |
| [Claude Code](../technology/claude-code.md) · [GitHub Copilot](../technology/github-copilot.md) | Draft the Red Test from the Story's technical AC. |
| [GitHub](../technology/github.md) | Commit the Red Test alongside the Story reference. |

## Agent protocol

1. Read the Story's technical AC.
2. Route the test type — Vitest vs. Playwright — by the AC shape (behavior vs. user-facing flow).
3. Derive the test file path deterministically from the Story identifier.
4. Draft the test; assert the AC.
5. Run the test. Confirm red; confirm the failure message points at missing/incomplete code, not at infrastructure.
6. Commit the Red Test. Advance to [Stage 7: Recursive Build](recursive-build.md).
