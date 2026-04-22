# Stage 7: Recursive Build

Detail page for the Workflow **Recursive Build** row — Signal: "Test exists and fails; named artifact absent or incomplete".

## Purpose

The Recursive Build implements the smallest unit that turns the Red Test green, then refactors under a green test, then composes the next unit from already-tested sub-units. **Recursive** means every composed unit is built from already-tested smaller units. No unit enters the build whose dependencies are not themselves under test.

This discipline is what makes Stage 10's Dual-AC Verification auditable. If the build respects recursion, each green test proves its unit works, and composed units inherit correctness from composed tests. If the build violates recursion — if it composes untested units — then greenness at the top does not prove correctness underneath, and a later regression cannot be localized.

This is also the stage where the bulk of Standard Platform tools come into play. The Red Test fixed the contract; this stage is where the contract is met.

## Enter / Exit

- **Enter when:** A Red Test exists and fails; the named artifact it asserts against is absent or incomplete.
- **Exit when:** All tests are green — the Red Test for this Story plus every test covering units composed into it — with no new untested dependencies introduced.

## Rule

Red → Green → Refactor, applied recursively. Refactor only under a green test. Never compose an untested unit into a tested one — if a sub-unit needs to exist, it gets its own Red Test first (loop back to [Stage 6](red-tests.md) for that sub-unit).

## Artifact produced

The implementation code that turns the Red Test green, plus any sub-unit tests written along the way.

## Standard Platform tools

| Tool | When to reach for it at this stage |
|------|------------------------------------|
| [Next.js](../technology/next-js.md) | Application framework: routes, pages, data fetching, rendering. |
| [TypeScript](../technology/typescript.md) | Types the contract between units; strict mode catches drift. |
| [Tailwind CSS](../technology/tailwind.md) | Styling primitive for UI units. |
| [Radix via shadcn/ui](../technology/radix-shadcn.md) | Composable primitives (dialog, menu, tooltip) when a Story needs them. |
| [v0](../technology/v0.md) | Accelerate UI component scaffolds from the locked design Story (Stage 4). |
| [npm](../technology/npm.md) | Dependency installs; `npm ci` for reproducible installs during build. |
| [Vitest](../technology/vitest.md) | Watch mode during build; fast feedback on non-UI units. |
| [Playwright](../technology/playwright.md) | Run the E2E Red Test locally; re-run on each iteration. |
| [Next.js DevTools MCP](../technology/next-js-devtools-mcp.md) | Resolve framework questions that arise mid-build (routing, caching, data fetching semantics). |
| [Chrome DevTools MCP](../technology/chrome-devtools-mcp.md) | Inspect the running page — DOM, network, console — when observed behavior does not match the test's expectation. |
| [Playwright MCP](../technology/playwright-mcp.md) | Scripted browser interactions for manual verification of a UI unit before committing. |
| [Vercel MCP](../technology/vercel-mcp.md) | Check Preview deployment state for builds that depend on Vercel runtime behavior. |
| [Claude Code](../technology/claude-code.md) | Primary author of implementation code. |
| [GitHub Copilot](../technology/github-copilot.md) | Inline authoring assistance. |
| [Microsoft Docs MCP](../technology/microsoft-docs-mcp.md) | Ground Microsoft/Azure APIs when the build touches them. |

## Agent protocol

1. Run the Red Test. Confirm it still fails for the right reason.
2. Implement the smallest unit that turns it green.
3. Run the test. Confirm green.
4. Refactor as needed — but only with the test green.
5. If composing a new unit, that sub-unit gets its own Red Test first; loop to [Stage 6](red-tests.md) for it.
6. Continue until all tests — this Story's Red Test and every composed sub-unit's test — are green.
7. Advance to [Stage 8: Local Verification](local-verification.md).
