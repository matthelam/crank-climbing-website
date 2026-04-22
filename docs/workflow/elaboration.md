# Stage 2: Elaboration

Detail page for the Workflow **Elaboration** row — Signal: "Scope exists; no Elaboration".

## Purpose

Elaboration expands a Scope statement into actionable detail — the risks, assumptions, stakeholders, and open questions that stand between the problem and a Requirement. Scope names the frame; Elaboration names the forces acting on that frame. It is the last stage where ambiguity is cheap: once Requirements lock in Stage 3, changing direction costs tests, implementation, review, and deploys.

Agents that skip Elaboration write Requirements that are speculative — grounded in unstated assumptions that later surface as blocking questions. An Elaboration that surfaces assumptions early keeps Stage 3 decisions honest.

## Enter / Exit

- **Enter when:** A Scope document exists, but no Elaboration of that Scope exists.
- **Exit when:** An Elaboration document exists that makes the Scope actionable — risks named, assumptions stated, stakeholders identified, open questions resolved or explicitly flagged.

## Rule

Do not advance from Scope to Requirements without an Elaboration that surfaces risks and assumptions. A Requirement authored against unstated assumptions is a Requirement waiting to be rewritten.

## Artifact produced

An Elaboration document linked to the Scope. Captures: risks, assumptions, stakeholders, open questions (each answered or deferred).

## Standard Platform tools

| Tool | When to reach for it at this stage |
|------|------------------------------------|
| [GitHub](../technology/github.md) | Host the Elaboration alongside the Scope. |
| [Claude Code](../technology/claude-code.md) · [GitHub Copilot](../technology/github-copilot.md) | Draft the Elaboration; surface unstated assumptions that the human can confirm or reject. |
| [LangGraph](../technology/langgraph.md) | Promote additional Tier 2 Insights into the Elaboration when they resolve open questions. |
| [Microsoft Docs MCP](../technology/microsoft-docs-mcp.md) · [Next.js DevTools MCP](../technology/next-js-devtools-mcp.md) · [Vercel MCP](../technology/vercel-mcp.md) · [Chrome DevTools MCP](../technology/chrome-devtools-mcp.md) | Ground technical feasibility claims — platform limits, framework support, runtime constraints. |
| [Figma](../technology/figma.md) | If Scope involves user-facing surface, pull design context early; do not commit to UI Requirements without knowing what design source exists. |

## Agent protocol

1. Read the Scope. Identify assumptions implied by its problem statement and outcome.
2. For each assumption, either resolve it with MCP-grounded evidence or flag it as open.
3. Enumerate risks — what could make this work impossible, costly, or reversible only at cost?
4. Name stakeholders and primary users.
5. Draft the Elaboration. Link it to the Scope.
6. Lock once the human confirms. Changes produce superseding Elaborations.
