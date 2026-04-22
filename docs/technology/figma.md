# Figma

**Status:** Resource ladder populated from official Figma docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Figma** row — Signal: "Design source of truth".

## Rule

Figma is the binding design source of truth. Agents must consume frames through the official Figma MCP server (remote `https://mcp.figma.com/mcp` or the Dev Mode desktop server), not via screenshots or scraped HTML — so tokens, variables, and Code Connect mappings flow into generated Next.js code. The pattern: select a frame in Dev Mode, share its node URL, and call `get_design_context` / `get_variable_defs`.

## Common patterns

- Remote MCP server (recommended) — [Figma docs](https://developers.figma.com/docs/figma-mcp-server/remote-server-installation/)
- Desktop MCP server (Dev Mode toggle, loopback `127.0.0.1:3845/mcp`) — [Figma docs](https://developers.figma.com/docs/figma-mcp-server/local-server-installation/)
- Link-based workflow: select frame, share node URL, call `get_design_context` / `get_variable_defs` — [Figma help](https://help.figma.com/hc/en-us/articles/39216419318551-Get-started-with-the-Figma-MCP-server)
- Tools and prompts reference (what each MCP tool returns) — [Figma docs](https://developers.figma.com/docs/figma-mcp-server/tools-and-prompts/)
- Code Connect for component-to-code binding so MCP returns real component names — [Figma help](https://help.figma.com/hc/en-us/articles/32132100833559-Guide-to-the-Figma-MCP-server)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | Figma plugin for Claude Code (bundles MCP settings + Agent Skills) | Beta (unversioned) | [help.figma.com/hc/en-us/articles/39888612464151](https://help.figma.com/hc/en-us/articles/39888612464151) |
| 2 | N/A — Figma is a web/desktop app; no official CLI. | N/A | [Figma MCP local install](https://developers.figma.com/docs/figma-mcp-server/local-server-installation/) |
| 3 | Figma MCP server (remote + Dev Mode desktop, first-party) | Public beta (no semver); endpoint `https://mcp.figma.com/mcp` | [developers.figma.com/docs/figma-mcp-server](https://developers.figma.com/docs/figma-mcp-server/) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
