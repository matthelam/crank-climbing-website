# npm

**Status:** Resource ladder populated from official npm docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **npm** row — Signal: "Installing and managing dependencies".

## Rule

Commit `package-lock.json` and use `npm ci` in CI / deploy for reproducible installs. Keep caret-range dependencies in `package.json` (pinning is the lockfile's job). Treat `npm audit` findings at high or critical severity as release blockers.

## Common patterns

- Commit `package-lock.json` for reproducible trees across team and CI — [npm docs](https://docs.npmjs.com/cli/v11/configuring-npm/package-lock-json/)
- Use `npm ci` in CI for strict, lockfile-only installs — [npm docs](https://docs.npmjs.com/cli/v11/commands/npm-ci/)
- Express dependency ranges with semver caret (`^`) / tilde (`~`) in `package.json` — [npm docs](https://docs.npmjs.com/about-semantic-versioning/)
- Run `npm audit` (auto-runs on install) and `npm audit fix` for vulnerability remediation — [npm docs](https://docs.npmjs.com/cli/v11/commands/npm-audit/)
- Track drift with `npm outdated` before upgrades — [npm docs](https://docs.npmjs.com/cli/v11/commands/npm-outdated/)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no npm-published skill package under the `npm` org. | N/A | N/A |
| 2 | `npm` (bundled with Node.js; also distributed separately) | 11.12.1 (2026-03-26; legacy line 10.9.7 maintained) | [docs.npmjs.com/cli/v11/commands/npm](https://docs.npmjs.com/cli/v11/commands/npm/) · [releases](https://github.com/npm/cli/releases) |
| 3 | None — no MCP server published by the `npm` GitHub org or docs.npmjs.com as of 2026-04-22. | N/A | N/A |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
