# Storybook

**Status:** Resource ladder scaffolded; version cells marked *[verify]* — pin before lock-once.

Detail page for the Standard Platform **Storybook** row — Signal: "Developing and visually testing components in isolation".

## Rule

Use Storybook as the canonical environment for developing UI components in isolation. Stories are the contract: every component delivered under Atomic Design has at least one story per meaningful state.

**In scope for Storybook tests:**
- Component functionality — props, internal state, events, interaction behaviour via the `play` function.
- Theme application — the design system applied correctly to the component (tokens, variants, dark/light, density).
- UI requirements at the component level — W3C accessibility conformance and related a11y rules *[TBD: link the project's W3C/a11y target once defined]*.

**Out of scope for Storybook:**
- Anything that only exists at page level — routes, data loading, navigation, cross-component flows, business-process verification. Storybook never sees an assembled page and must not pretend to.

Defer to **Playwright** for end-to-end behaviour across composed routes (the assembled product), and **Vitest** for non-UI logic. Storybook owns the component layer in between.

## Common patterns

- One story file per component, co-located with the source (`Component.stories.tsx`) — [Storybook docs](https://storybook.js.org/docs/writing-stories)
- Use the Component Story Format (CSF) `meta` + named exports for variants — [Storybook docs](https://storybook.js.org/docs/api/csf)
- Drive interaction tests with the `play` function and `@storybook/test` for assertions — [Storybook docs](https://storybook.js.org/docs/writing-tests/interaction-testing)
- Run stories headlessly in CI via the test runner (`storybook test` / `test-storybook`) — [Storybook docs](https://storybook.js.org/docs/writing-tests/test-runner)
- Pair with shadcn/ui primitives: write stories for the composed component, not for Radix internals — see [radix-shadcn.md](radix-shadcn.md)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no Storybook-published Claude Code skill at the time of writing. | N/A | N/A |
| 2 | `storybook` (via `npx storybook`) — `init`, `dev`, `build`, `test` | *[verify]* | [storybook.js.org/docs/api/cli-options](https://storybook.js.org/docs/api/cli-options) |
| 3 | None — covered by the Storybook MCP row separately. | N/A | see [storybook-mcp.md](storybook-mcp.md) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
