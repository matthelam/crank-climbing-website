---
description: Author a feature spec under specs/[feature-id]/spec.md
argument-hint: "<feature-id> <one-line problem statement>"
---

Create `specs/$1/spec.md` from `.specify/templates/spec-template.md` for the problem described in `$2`.

Required steps:

1. Confirm the Crank constitution is loaded (`/speckit.constitution`).
2. Trace the spec to **exactly one** business principle (Conversion / Consideration / Retention).
3. Decompose the problem into Stories. Every Story is component-shaped (Storybook-testable). Page-assembly Stories must declare dependencies on Component Stories.
4. Capture the business outcome as goal-level AC — phrased so a single Playwright test could assert it end-to-end.
5. Cite source provenance (Notion ticket / Figma frame / stakeholder ask). Reject if absent.
6. Lock the spec — no further edits to this file. Changes produce a new feature ID.
