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

Every Story is component-shaped — testable as a single unit in Storybook — and carries technical AC testable by a single named test file. Every Task names a single executable unit. Stories and Tasks are locked once authored; changes produce new Stories and Tasks, never edits to existing ones.

## Story shape and Feature scope

- **Story = component.** A Story is a UI unit testable in isolation in Storybook — functionality, theme application, W3C accessibility. A Story may declare dependencies on other Stories: a page-assembly Story is one whose dependencies are the Component Stories it composes. The assembly itself is renderable in Storybook, but page-level concerns (routes, data loading, business flows) sit one tier up.
- **Feature = business process.** A Feature is the business process the assembled product delivers across one or more Stories. Its test layer is Playwright, validating the assembled site against business requirements end-to-end.
- **Non-UI work** belongs to a Task whose Red Test is Vitest, not a Story.

The Story type fixes both its dependency shape and its Stage 6 test framework — see [red-tests.md](red-tests.md).

## Artifact produced

Stories (future: `intent/stories/`) with technical AC. Tasks (future: `intent/tasks/`). Each linked to its parent. Each traceable upward to Requirement → Elaboration → Scope.


## Agent protocol

1. Read the Requirement (and design Story, if UI is involved).
2. Enumerate Story candidates — each a component-shaped deliverable with one testable technical AC. For each Story, declare its dependency Stories (empty for atomic components; populated for page assemblies). Identify the parent Feature (the business process the Story contributes to).
3. Phrase each technical AC as a statement assertable by a single test. Reject AC that maps to multiple test files or to none.
4. Decompose each Story into Tasks — smallest unit that can be implemented, tested, and committed in one pass.
5. Link Stories to Requirement and to their parent Feature; link Story-to-Story dependencies; link Tasks to Stories.
6. Lock once the human confirms. Advance to [Stage 6: Red Tests](red-tests.md).
