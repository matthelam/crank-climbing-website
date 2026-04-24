---
description: Read and confirm the Crank constitution before any spec work
---

Load `.specify/memory/constitution.md` and confirm the binding constraints with the user before any `/speckit.specify` work begins:

1. The Standard Platform is closed — only tools listed there are approved.
2. The test ladder (Story = Storybook, Feature = Playwright, Storybook-green precedes Playwright-green) is non-negotiable.
3. Lock-once applies to every spec/plan/task artifact under `specs/`.

If the user is proposing work that violates any of the above, surface the conflict and stop. Constitution amendments are out-of-band and require human authorship.
