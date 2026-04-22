# Stage 11: Review

Detail page for the Workflow **Review** row — Signal: "PR verified; not yet approved".

## Purpose

Review applies human judgment to what CI and Dual-AC Verification cannot measure. CI proves tests pass. Dual-AC Verification proves outcomes are met. Review asks the orthogonal question: **is this the right change?**

A PR can pass every test, satisfy both AC, and still violate a principle — introducing a hidden coupling, bypassing a convention, or solving the stated problem in a way that creates a larger unstated problem. Review catches this class of failure, which is invisible to automated gates.

Review is also the **lock point for delivery intent**: once approved, the PR advances to Stage 12 and becomes a deployed change. Review feedback that requires modifications loops back to [Stage 7](recursive-build.md) or [Stage 8](local-verification.md); it does not rewrite the approved PR under the review.

## Enter / Exit

- **Enter when:** PR verification notes exist (both AC covered); PR is not yet approved.
- **Exit when:** PR is approved — reviewer has signed off against Technology Principles and Engineering Practices.

## Rule

Review assesses what automated gates cannot — fit against principles, design choices, and whether the change is the right change. Review feedback that requires modification loops back to implementation or verification; it does not rewrite the PR under an open approval.

## Artifact produced

Approval on the PR.

## Review checklist (suggested)

Anchored in the README:

- **Business Principles:** does the change serve the stated business principle?
- **Technology Principles:** does the change respect the Signal/Key/Detail grammar, lock-once discipline, and router-table routing?
- **Engineering Practices:** TDD (red first, recursive), SOLID, TypeScript strict, Vitest for non-UI, Playwright for UI?
- **Lock-once discipline:** does the change edit a locked artifact (Scope, Elaboration, Requirement, Story, Task)? If so, route it to a superseding artifact.
- **Standard Platform routing:** does the change use the Key from the Standard Platform table for each concern, or does it reach for an off-table tool without justification?

## Standard Platform tools

| Tool | When to reach for it at this stage |
|------|------------------------------------|
| [GitHub](../technology/github.md) | Review comments, approval. |
| [Claude Code](../technology/claude-code.md) | Draft review comments as a second set of eyes; cite principles by reference. Never approves autonomously. |
| [GitHub Copilot](../technology/github-copilot.md) | Inline review assistance for the reviewer. |
| [Next.js DevTools MCP](../technology/next-js-devtools-mcp.md) · [Vercel MCP](../technology/vercel-mcp.md) · [Chrome DevTools MCP](../technology/chrome-devtools-mcp.md) | Ground review comments — is this actually how the framework handles this? does the edge runtime support this API? what does the Preview show? |
| [Microsoft Docs MCP](../technology/microsoft-docs-mcp.md) | Ground review comments touching Microsoft/Azure platform behavior. |

## Agent protocol

1. Read the PR, Story, Requirement, and verification notes.
2. Walk the review checklist against the diff.
3. For each concern, cite the specific principle or practice and propose the remedy.
4. If clean, approve. If not, request changes; the author loops back to [Stage 7](recursive-build.md).
5. Approval is the handoff to [Stage 12: Merge + Deploy + Observe](merge-deploy-observe.md).
