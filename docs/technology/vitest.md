# Vitest

**Status:** Resource ladder populated from official Vitest docs as of 2026-04-22.

Detail page for the Standard Platform **Vitest** row — Signal: "Verifying non-UI logic".

## Rule

Use Vitest to verify non-UI logic — utilities, server helpers, pure functions, API handlers. Vitest is the Vite-native testing framework with out-of-the-box TypeScript/JSX support, Jest-compatible `expect`/mocking APIs, and instant watch mode (HMR for tests).

UI component tests do not belong here — use **Storybook** for component-level behaviour, theming, and accessibility, and **Playwright** for end-to-end behaviour across composed routes.

## Common patterns

- Writing tests with `describe` / `it` / `expect` — [Vitest docs](https://vitest.dev/guide/)
- Mocking modules, timers, env, and globals via `vi` — [Vitest docs](https://vitest.dev/guide/mocking)
- Native code coverage via `v8` (default) or `istanbul` — [Vitest docs](https://vitest.dev/guide/coverage)
- CLI: `vitest` (watch in dev), `vitest run` (CI single pass), `vitest related` — [Vitest CLI](https://vitest.dev/guide/cli)
- Vitest 4.1+ ships a built-in `agent` reporter, auto-enabled when an AI coding agent is detected — [Vitest 4.1 release](https://vitest.dev/blog/vitest-4-1.html)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no standalone skill package. Vitest 4.1 ships a built-in `agent` reporter inside the core package. | N/A | [Vitest 4.1 release notes](https://vitest.dev/blog/vitest-4-1.html) |
| 2 | `vitest` | 4.1.5 | [vitest.dev/guide/cli](https://vitest.dev/guide/cli) |
| 3 | None — only an open feature request (`vitest-dev/vitest#8411`). | N/A | [vitest-dev/vitest#8411](https://github.com/vitest-dev/vitest/issues/8411) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
