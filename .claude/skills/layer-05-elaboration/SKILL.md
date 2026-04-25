---
name: layer-05-elaboration
description: Risk-driven analysis of the locked scope (layer 05). Invoked by orchestration/graphs/layer_05_elaboration.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 05 — Elaboration

Risk-driven analysis of the locked scope. Surface integrations, complexities, architectural calls, sequencing constraints.

**Contract:** [`layers/05-elaboration/layer.md`](../../../layers/05-elaboration/layer.md). **Schema:** [`layers/05-elaboration/schema.output.json`](../../../layers/05-elaboration/schema.output.json).

## Steps

1. Read scope (`04`).
2. For each `in` business function, identify:
   - **Integrations** — external systems (auth, payment, CMS, analytics) needed.
   - **Risks** — what could go wrong, ranked H/M/L.
   - **Architectural calls** — ADR-shaped: option A vs B, tradeoffs, recommendation. Cite `mcp_nextjs_devtools` or `mcp_microsoft_docs` for upstream evidence.
   - **Sequencing constraints** — what must come before what.
3. Write `intent/elaborations/{slug}-{ISO-timestamp}.md` with a "References" section listing every doc lookup citation.
4. Reply with the path.

## Failure modes

| Failure | Recovery |
|---|---|
| Architectural call lacks doc citation | Surface; do not commit speculation. |
| MCP doc lookup unavailable | Mark the call as "needs verification" and flag in HITL trigger. |

## Lock-once

Never edit a prior elaboration. Revisions produce a new file with `supersedes` set.
