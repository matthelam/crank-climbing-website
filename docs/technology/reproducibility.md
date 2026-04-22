# Reproducibility

Detailed mechanisms behind the reproducibility rule stated in the root [`README.md`](../../README.md) Technology Principles.

**Status: placeholder.** Content to be materialised — see [root README → TODO](../../README.md#todo).

## Planned contents

- **Intent artifacts vs. delivery artifacts** — Requirements, User Stories, and Test Plans are intent artifacts in natural language; code, configuration, infrastructure, and tests are delivery artifacts that must be deterministic.
- **Per-type reproducibility mechanisms**
  - Code changes: reversed through version control; no backout logic inside the application.
  - Infrastructure and data changes: reconcile to declared state, or ship with paired forward/backout scripts.
  - Irreversible actions (domain registration, one-time OAuth, external notifications): committed as a record of the act; the repo remains the truthful source even when the act itself cannot be undone.
- **Story/Task completion definition** — complete only when the named artifacts exist in the repository, pass their tests, and are committed.
- **Idempotence expectation** — every script safely reconciles to declared state; re-running never duplicates work or causes harm.
