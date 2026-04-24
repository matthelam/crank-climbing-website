---
description: Author the implementation plan under specs/[feature-id]/plan.md
argument-hint: "<feature-id>"
---

Create `specs/$1/plan.md` from `.specify/templates/plan-template.md`, derived from `specs/$1/spec.md`.

Required steps:

1. Read the spec; reject if not locked.
2. Select tools **only from the Standard Platform** in the constitution. No new dependencies — if the spec requires capability the platform doesn't cover, stop and surface.
3. Build the component inventory (atomic-design classified) and the page-assembly list. Every Story from the spec maps to one row.
4. Confirm the test layer routing for every Story type (Storybook / Playwright / Vitest).
5. Order Stories by dependency so `/speckit.tasks` can produce a valid Storybook-before-Playwright build graph.
6. Record rejected alternatives with one-line reasons.
7. Lock the plan.
