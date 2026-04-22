# Stage 10: Dual-AC Verification

**Status: *[TBD]*** — scaffolding only.

Detail page for the Workflow **Dual-AC Verification** row — Signal: "PR open with green CI; no verification notes referencing both AC".

## Planned contents

- Verifying the goal-level AC (from the Requirement) and the technical AC (from the Story) in the same PR notes.
- Where verification notes live (PR description, linked artifact, or comment).
- Why both: technical AC can pass while goal-level AC silently drifts, and vice versa.
- Exit condition: PR verification notes reference both AC — advance to [Stage 11: Review](review.md).

This document will elaborate the above into a concrete protocol. Until then, apply the spirit: a green CI proves technical AC; it does not prove goal-level AC — both must be asserted before review.
