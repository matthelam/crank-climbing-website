---
description: Generate the per-Task list under specs/[feature-id]/tasks.md
argument-hint: "<feature-id>"
---

Create `specs/$1/tasks.md` from `.specify/templates/tasks-template.md`, derived from `specs/$1/plan.md`.

Required steps:

1. Read the plan; reject if not locked.
2. For each Story in the plan, emit a Task with:
   - Story type (Component / Page assembly / Feature / Non-UI)
   - Red Test framework (Storybook / Playwright / Vitest) — routed by Story type per the constitution
   - Deterministic Red Test file path derived from the Story ID
3. Order Tasks so Component Stories precede Page assembly Stories precede Feature Tasks. Storybook-green precedes Playwright-green.
4. Verify every Task produces a single named test file. Reject AC that maps to multiple files.
5. Lock the task list.
