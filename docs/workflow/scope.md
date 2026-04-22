# Stage 1: Scope

Detail page for the Workflow **Scope** row — Signal: "No Scope document exists".

## Purpose

Scope defines the problem-to-solution boundary. It answers three questions: what problem are we solving, what outcome means the problem is solved, and what is deliberately out of scope. Every downstream stage (Elaboration, Requirements, Stories, Tests, Code) derives its legitimacy from the Scope that spawned it. Without Scope, there is no auditable intent — only ad-hoc work.

Scope is not a solution. It is the frame the solution must fit inside. Agents that jump from a request directly to code bypass the only stage where problem definition is still cheap to change.

## Enter / Exit

- **Enter when:** No Scope document exists for the current request.
- **Exit when:** A Scope document exists naming problem, desired outcome, and explicit non-goals — linked from the originating issue or PR.

## Rule

Do not author Elaboration, Requirements, Stories, or code until a Scope document exists for the work. If a request arrives without a Scope, the agent's first act is to surface the missing Scope to the human, not to start implementing.

## Artifact produced

A Scope document. Until the `intent/` schema lands, it lives as a markdown document (issue body, discussion, or dedicated file) linked from the initiating issue or PR.


## Agent protocol

1. Check whether a Scope document exists for the request. If yes, advance to Stage 2.
2. If no, halt authoring of Elaboration, Requirements, Stories, or code.
3. Surface the missing Scope to the human. Offer to draft, but do not lock it without sign-off.
4. Once drafted and confirmed, store where intent lives and link it from the originating artifact.
5. Mark the Scope as locked. Subsequent changes produce superseding Scope documents, not edits to this one.
