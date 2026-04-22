# Stage 12: Merge + Deploy + Observe

**Status: *[TBD]*** — scaffolding only.

Detail page for the Workflow **Merge + Deploy + Observe** row — Signal: "PR approved; not merged / observability not resumed".

## Planned contents

- Merge discipline — squash vs. rebase, branch cleanup, commit message convention.
- Deploy trigger — Vercel's Git integration promotes `main` to Production automatically.
- Resume observability — Vercel runtime logs, Vercel Analytics, Speed Insights — and what to watch for immediately post-deploy.
- Exit condition: merged, deployed, and observability resumed — the Workflow is complete for this Task.

This document will elaborate the above into a concrete protocol. Until then, apply the spirit: the Workflow does not end at merge — it ends when the deployed change is under active observation.
