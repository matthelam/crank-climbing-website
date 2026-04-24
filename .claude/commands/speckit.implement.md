---
description: Execute the Recursive Build for a locked task list
argument-hint: "<feature-id>"
---

Execute the Tasks under `specs/$1/tasks.md` following the Crank Recursive Build discipline (Workflow Stages 6–8 — see `docs/workflow/recursive-build.md`).

For each Task in dependency order:

1. **Red Test first.** Author the failing test at the deterministic path; confirm it fails for the **right reason** (missing code, not infrastructure).
2. **Implement the smallest unit** that turns the Red Test green.
3. **Refactor under green** if needed.
4. **Sub-units get their own Red Test** — never compose untested units into tested ones. Loop back to `/speckit.tasks` for the sub-Story if scope expands.
5. **Storybook-green precedes Playwright-green.** Do not start a Feature-tagged Task until every dependent Component / Page assembly Task is green.
6. **Local Verification (Stage 8)** — type-check, lint, build clean before advancing.

Stages 9–12 (PR → Dual-AC → Review → Merge+Deploy+Observe) are out of scope for `/speckit.implement` and remain Crank-specific. See `docs/workflow/`.
