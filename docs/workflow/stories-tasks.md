# Stage 5: Stories + Tasks

Detail page for the Workflow **Stories + Tasks** row — Signal: "Requirement exists; no decomposed Stories with technical AC".

## Purpose

Stories decompose a Requirement into deliverable increments. Each Story carries **technical Acceptance Criteria** — the contract that a Red Test (Stage 6) will assert against. Tasks decompose a Story into the smallest executable units — each committable, reviewable, and reversible independently.

This is the stage where *outcome* becomes *plan*. Goal-level AC (from the Requirement) is outcome-shaped; technical AC (from the Story) is testable. An agent generating code from a Story must see technical AC that is unambiguous enough to map to a single test file — otherwise Stage 6 cannot produce a named, deterministic Red Test.

A Requirement can produce many Stories; each Story produces one or more Tasks. The decomposition is where slack in the plan is either surfaced (before code) or hidden (to be discovered during implementation).

## Enter / Exit

- **Enter when:** A Requirement exists (and, if UI, a design Story exists); no Stories with technical AC have been decomposed from it.
- **Exit when:** Stories exist for the Requirement, each with unambiguous technical AC, each linked to the parent Requirement. For each Story, Tasks exist that decompose it into executable units.

## Rule

Every Story carries technical AC testable by a single named test file. Every Task names a single executable unit. Stories and Tasks are locked once authored; changes produce new Stories and Tasks, never edits to existing ones.

## Artifact produced

Stories (future: `intent/stories/`) with technical AC. Tasks (future: `intent/tasks/`). Each linked to its parent. Each traceable upward to Requirement → Elaboration → Scope.

## Standard Platform tools

| Tool | When to reach for it at this stage |
|------|------------------------------------|
| [GitHub](../technology/github.md) | Intent storage. |
| [Claude Code](../technology/claude-code.md) | Primary decomposer: Requirements → Stories, Stories → Tasks. Enforces the lock-once rule. |
| [LangGraph](../technology/langgraph.md) | Orchestrates decomposition ceremonies; enforces schema compliance on emitted Stories and Tasks. |
| [GitHub Copilot](../technology/github-copilot.md) | Inline decomposition assistance in the IDE. |
| [Microsoft Docs MCP](../technology/microsoft-docs-mcp.md) · [Next.js DevTools MCP](../technology/next-js-devtools-mcp.md) · [Vercel MCP](../technology/vercel-mcp.md) | Ground technical feasibility; inform technical AC phrasing (e.g., what data-fetching API the Story implies). |
| Figma MCP — covered on [figma.md](../technology/figma.md) | When a Story touches UI, reference the design source from the technical AC. |

## Agent protocol

1. Read the Requirement (and design Story, if UI is involved).
2. Enumerate Story candidates — each a deliverable increment with one testable technical AC.
3. Phrase each technical AC as a statement assertable by a single test. Reject AC that maps to multiple test files or to none.
4. Decompose each Story into Tasks — smallest unit that can be implemented, tested, and committed in one pass.
5. Link Stories to Requirement; link Tasks to Stories.
6. Lock once the human confirms. Advance to [Stage 6: Red Tests](red-tests.md).
