# Playwright

**Status:** Resource ladder populated from official Playwright (Microsoft) docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Playwright** row — Signal: "Verifying UI behaviour end-to-end".

## Rule

Use Playwright as the sole end-to-end test runner for this Next.js repo. Verify behaviour through user-visible output (rendered DOM, navigation, network) rather than implementation details. In CI, run on Linux with only the browsers under test installed.

## Common patterns

- Web-first auto-retrying assertions via `expect(locator).toBeVisible()` — [Playwright docs](https://playwright.dev/docs/best-practices#use-web-first-assertions)
- User-facing locators (`getByRole`, `getByLabel`, `getByText`) over CSS/XPath — [Playwright docs](https://playwright.dev/docs/locators)
- Test isolation with a fresh `BrowserContext` per test (default behaviour) — [Playwright docs](https://playwright.dev/docs/browser-contexts)
- Trace Viewer on first retry for CI debugging (`trace: 'on-first-retry'`) — [Playwright docs](https://playwright.dev/docs/trace-viewer-intro)
- Sharding plus CI-only browser installs for fast pipelines — [Playwright docs](https://playwright.dev/docs/test-sharding)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | `@playwright/cli` (Microsoft-published skill for coding agents; `playwright-cli install --skills` pulls the richer skill bundle) | Tracks Playwright 1.59.x | [playwright.dev/docs/getting-started-cli](https://playwright.dev/docs/getting-started-cli) |
| 2 | `playwright` (via `npx playwright`) | 1.59.1 | [playwright.dev/docs/test-cli](https://playwright.dev/docs/test-cli) |
| 3 | None — covered by the Playwright MCP row separately. | N/A | see [playwright-mcp.md](playwright-mcp.md) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
