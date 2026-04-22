# Stage 9: Pull Request

**Status: *[TBD]*** — scaffolding only.

Detail page for the Workflow **Pull Request** row — Signal: "Clean locally; no PR open for this branch".

## Planned contents

- PR body template — links to the Story and Task, summary of change, test evidence.
- Branch naming convention tied to Story identifier.
- Expectation that CI is green on the PR head commit before handing off for verification.
- Exit condition: PR is open with green CI — advance to [Stage 10: Dual-AC Verification](dual-ac-verification.md).

This document will elaborate the above into a concrete protocol. Until then, apply the spirit: the PR is the contract between the author's local claim of "done" and the downstream verification, review, and deploy stages.
