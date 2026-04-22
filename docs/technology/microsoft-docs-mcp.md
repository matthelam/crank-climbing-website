# Microsoft Docs MCP

**Status:** Resource ladder populated from official Microsoft Learn docs as of 2026-04-22; body remains *[TBD]*.

Detail page for the Standard Platform **Microsoft Docs MCP** entry — Signal: "Looking up Microsoft / Azure documentation".

## Rule

For Microsoft or Azure documentation lookups in this Next.js repo (Azure SDKs, App Service / Static Web Apps hosting, Entra ID auth, MSAL.js), invoke the Microsoft Learn MCP Server so the agent retrieves trusted, up-to-date Microsoft Learn content instead of relying on training-cutoff knowledge. The server is a remote streamable-HTTP MCP with no authentication required.

## Common patterns

- Semantic search across official Microsoft / Azure docs via `microsoft_docs_search` — [Learn MCP developer reference](https://learn.microsoft.com/en-us/training/support/mcp-developer-reference)
- Fetch a full Learn article as markdown via `microsoft_docs_fetch` — [Learn MCP release notes](https://learn.microsoft.com/en-us/training/support/mcp-release-notes)
- Retrieve official Microsoft / Azure code samples via `microsoft_code_sample_search` — [Learn MCP release notes](https://learn.microsoft.com/en-us/training/support/mcp-release-notes)
- Connect from VS Code / GitHub Copilot using the get-started guide — [Learn MCP get started](https://learn.microsoft.com/en-us/training/support/mcp-get-started)
- Connect from Azure AI Foundry agents — [Learn MCP + Foundry](https://learn.microsoft.com/en-us/training/support/mcp-get-started-foundry)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — no Anthropic- or Microsoft-published Claude skill for Microsoft Learn docs lookup. | N/A | N/A |
| 2 | N/A — MCP server, invoked via MCP protocol. | N/A | N/A |
| 3 | Microsoft Learn MCP Server (`MicrosoftDocs/mcp`) | GA since 2025-11-07; latest documented release 2025-12-10 | [github.com/MicrosoftDocs/mcp](https://github.com/MicrosoftDocs/mcp) · endpoint `https://learn.microsoft.com/api/mcp` ([Learn MCP support](https://learn.microsoft.com/en-us/training/support/mcp)) |
| 4 | see below | — | — |

## Custom rules

*[TBD]* — none yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
