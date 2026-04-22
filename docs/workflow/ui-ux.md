# Stage 4: UI/UX (conditional)

Detail page for the Workflow **UI/UX** row — Signal: "Requirement needs UI; no design Story or Figma source".

## Purpose

UI/UX is the stage that produces a **locked design source** before any UI code is written. Its purpose is to separate design decisions from implementation decisions. When design decisions live inside component files, they cannot be reviewed as design — they can only be reviewed as code, which is a different concern. A locked design source fixes that by making the design an intent artifact in its own right.

This stage is **conditional**: it applies only when the Requirement has a user-facing surface. Requirements that are purely backend, infrastructure, or API-level skip directly to [Stage 5: Stories + Tasks](stories-tasks.md).

Figma is the canonical design source. v0 can generate Next.js component scaffolds from Figma frames or prompts — but v0 is not a replacement for the lock; it is an accelerator between the locked design and the implementation.

## Enter / Exit

- **Enter when:** A Requirement needs UI; no design Story or Figma source exists for it.
- **Exit when:** A locked design source (Figma frame or equivalent) exists for the user-facing surface, and a design Story captures the design decisions and links to the source.
- **Skip when:** The Requirement has no user-facing surface — advance directly to [Stage 5](stories-tasks.md).

## Rule

Do not write UI code without a locked design source. A hand-drawn sketch, a stale Figma frame, an in-progress design, or a prompt-to-v0 output without a corresponding Figma frame are not design sources.

## Artifact produced

A Figma frame (or equivalent locked design) plus a design Story linking the Requirement to the design source. If v0 scaffolding was used, the scaffold is referenced from the design Story.

## Standard Platform tools

| Tool | When to reach for it at this stage |
|------|------------------------------------|
| [Figma](../technology/figma.md) | Design source of truth. Use Dev Mode for handoff. |
| Figma MCP (`https://mcp.figma.com/mcp`) — covered on [figma.md](../technology/figma.md) | Agents pull design tokens, component structure, and copy directly from Figma via MCP rather than screenshots. |
| [v0](../technology/v0.md) | Generate Next.js + Tailwind component scaffolds from a Figma frame or a prompt; never as a substitute for the Figma source. |
| [Tailwind CSS](../technology/tailwind.md) | Styling primitive used by generated and hand-written components. |
| [Radix via shadcn/ui](../technology/radix-shadcn.md) | Composable primitives (dialog, menu, tooltip) referenced by generated components. |
| [GitHub](../technology/github.md) | Store the design Story and the links to Figma. |
| [Claude Code](../technology/claude-code.md) | Draft the design Story; summarize Figma content into text an agent can consume. |

## Agent protocol

1. Determine whether the Requirement has a user-facing surface. If not, skip to Stage 5.
2. Check whether a Figma source exists for the surface. If not, request one; do not proceed to generate UI from prompts alone.
3. Pull design tokens, layout, and copy via Figma MCP.
4. Optionally generate a component scaffold via v0, keyed to the Figma frame.
5. Author a design Story linking Requirement → Figma frame → scaffold (if present).
6. Lock the design Story. Subsequent design changes produce superseding design Stories.
