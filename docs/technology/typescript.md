# TypeScript

**Status:** Resource ladder populated from official Microsoft / TypeScript docs as of 2026-04-22; body remains *[TBD]*.

Detail page for two Standard Platform rows — **TypeScript** (Signal: "Writing typed code") and **TypeScript strict** (Signal: "Enforcing type correctness").

## Rule

Adopt TypeScript in strict mode for all application and library code. Set `"strict": true` in `tsconfig.json` so every strict type-checking option is on. New Next.js projects scaffolded via `create-next-app` ship with `"strict": true` already set.

## Common patterns

- Compile via the official `tsc` CLI driven by `tsconfig.json` — [TypeScript handbook](https://www.typescriptlang.org/docs/handbook/compiler-options.html)
- Enable the bundled `strict` flag family (noImplicitAny, strictNullChecks, strictFunctionTypes, strictBindCallApply, strictPropertyInitialization, noImplicitThis, alwaysStrict, useUnknownInCatchVariables) — [TSConfig reference](https://www.typescriptlang.org/tsconfig/strict.html)
- Configure project settings through the TSConfig reference — [TSConfig reference](https://www.typescriptlang.org/tsconfig/)
- Use "Everyday Types" for primitives, objects, unions, generics — [TypeScript handbook](https://www.typescriptlang.org/docs/handbook/2/everyday-types.html)
- Track language changes via official release notes — [TypeScript 5.9 release notes](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-5-9.html)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — Microsoft does not publish an official TypeScript skill / instruction package (verified at github.com/microsoft/TypeScript and github.com/microsoft/mcp). | N/A | N/A |
| 2 | `tsc` | 6.0 | [typescriptlang.org/docs/handbook/compiler-options](https://www.typescriptlang.org/docs/handbook/compiler-options.html) |
| 3 | None — no official TypeScript-language MCP server (the `modelcontextprotocol/typescript-sdk` is for building MCP servers, not querying TypeScript). | N/A | N/A |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
