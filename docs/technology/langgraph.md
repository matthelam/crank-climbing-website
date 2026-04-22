# LangGraph

**Status:** Resource ladder populated from official LangChain docs as of 2026-04-22.

Detail page for the Standard Platform **LangGraph** row — Signal: "Orchestrating multi-step agent workflows (extraction ceremonies, verification gates)".

## Rule

Use LangGraph.js (the official TypeScript port) as the orchestration layer for any multi-step agent workflow in this Next.js repo — extraction ceremonies, verification gates, and human-in-the-loop checkpoints — rather than ad-hoc promise chains, so state, durability, and graph topology are first-class. Reserve the Python `langgraph` package + `langgraph-cli` for LangGraph Platform deployments; in-repo runtime stays JS/TS.

## Common patterns

- Stateful graph orchestration (nodes + edges + shared state) — [langgraphjs](https://github.com/langchain-ai/langgraphjs)
- Multi-agent supervisor pattern — [langgraph-supervisor](https://github.com/langchain-ai/langgraph-supervisor-py)
- Multi-agent swarm (dynamic handoff) pattern — [langgraph-swarm](https://github.com/langchain-ai/langgraph-swarm-py)
- Human-in-the-loop interrupt/resume gates — [langgraphjs](https://github.com/langchain-ai/langgraphjs)
- MCP tool consumption inside a graph via `@langchain/mcp-adapters` — [langchain-mcp-adapters](https://github.com/langchain-ai/langchainjs/tree/main/libs/langchain-mcp-adapters)

## Resource ladder

Agents resolve "how to use this tool" in tier order; stop at the first tier that answers the question. Tiers that do not apply for this tool are marked N/A.

- **Tier 1 — Official skill.** Vendor-endorsed skill package, scoped to this project.
- **Tier 2 — Official CLI.** Versioned binary with `--help` and vendor docs.
- **Tier 3 — Official MCP documentation.** Vendor MCP server, pinned to the version in use.
- **Tier 4 — Custom rules.** Project-specific guidance (below), used only when Tiers 1–3 cannot answer.

| # | Resource | Version | Pointer |
|---|----------|---------|---------|
| 1 | None — LangChain does not publish a Claude Code skill package for LangGraph. | N/A | N/A |
| 2 | `langgraph` (Python package `langgraph-cli`) | 0.4.23 (2026-04-17) | [pypi.org/project/langgraph-cli](https://pypi.org/project/langgraph-cli/) · [docs](https://langchain-ai.github.io/langgraph/) |
| 3 | None — LangChain publishes `langchain-mcp-adapters` (an MCP *client* for consuming MCP tools inside LangGraph agents), not an MCP server that exposes LangGraph itself. | N/A | [langchain-mcp-adapters](https://github.com/langchain-ai/langchain-mcp-adapters) |
| 4 | see below | — | — |

## Custom rules

None yet. Add only when Tiers 1–3 cannot answer a question that recurs in this project.
