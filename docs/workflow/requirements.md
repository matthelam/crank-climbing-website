# Stage 3: Requirements

Detail page for the Workflow **Requirements** row — Signal: "Elaboration exists; no Requirement with goal-level AC".

## Purpose

Requirements convert an Elaborated Scope into testable outcomes. A Requirement carries **goal-level Acceptance Criteria** — outcome-shaped, not implementation-shaped. The goal-level AC is what the user wants, independent of how it is built.

The asymmetry matters: a Requirement with implementation-shaped AC ("use React Context for cart state") couples the Requirement to a Story. A Requirement with outcome-shaped AC ("cart state persists across page refresh") leaves Stories free to choose technical approach. Agents generating code from Requirements must see outcomes, not implementations — otherwise Stage 5's decomposition has nothing left to decide.

This is also the last stage before the "what" is locked and the "how" enters the workflow. Every Requirement that passes here constrains every Story, Test, and line of code downstream.

## Enter / Exit

- **Enter when:** Elaboration exists; no Requirement with goal-level AC exists for it.
- **Exit when:** A Requirement exists with at least one goal-level AC — user-facing and outcome-shaped — linked to its parent Scope and Elaboration.

## Rule

Every Requirement carries at least one goal-level AC phrased as a user-facing outcome. Implementation-shaped AC is rejected and returned for rewriting. A Requirement without testable outcomes is a wish, not a Requirement.

## Artifact produced

A Requirement document (future location: `intent/requirements/` once the schema lands) with goal-level AC and links to its parent Scope and Elaboration.


## Agent protocol

1. Read the Elaboration. Identify candidate outcomes worth asserting.
2. Draft outcome-shaped AC for each candidate. Reject any draft that names a library, framework API, component, or data structure.
3. For measurable AC, link it to the Vercel Analytics event (or metric) that will verify it.
4. Link the Requirement to its parent Scope and Elaboration.
5. Lock once the human confirms. Changes produce superseding Requirements.
6. Route: if UI is involved, advance to [Stage 4: UI/UX](ui-ux.md); otherwise advance directly to [Stage 5: Stories + Tasks](stories-tasks.md).
