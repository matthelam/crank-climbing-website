---
name: layer-14-merge-deploy-observe
description: Merge, deploy, resume observability (layer 14). Invoked by orchestration/graphs/layer_14_merge_deploy_observe.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 14 — Merge + Deploy + Observe

Merge approved PR, deploy to Vercel, resume observability. Required HITL.

**Contract:** [`layers/14-merge-deploy-observe/layer.md`](../../../layers/14-merge-deploy-observe/layer.md). **Schema:** [`layers/14-merge-deploy-observe/schema.output.json`](../../../layers/14-merge-deploy-observe/schema.output.json).

## Steps

1. Read review record from `13` (must be approved). Read PR record from `11`.
2. Merge the PR via `gh pr merge --squash --delete-branch` (squash policy keeps clean linear history).
3. Capture resulting commit SHA on `main`.
4. Watch Vercel deployment for the new commit:
   - `vercel inspect <deploy-url> --wait` or poll `vercel deployments list --limit 1`.
   - Confirm health check (HTTP 200 on production URL root).
5. Resume observability:
   - Confirm `vercel-analytics` instrumentation live.
   - Note runtime observability dashboard URL for new deploy.
6. Smoke check: navigate to 3-5 representative routes via `mcp_playwright`; confirm no console errors.
7. Write `intent/deployments/{commit-sha}-{ISO-timestamp}.md` with: commit SHA, deploy URL, dashboard links, smoke results.
8. Reply with the deployment record path on the final line.

## HITL

`required` — human acknowledges go-live before orchestrator marks slice complete.

## Failure modes

| Failure | Recovery |
|---|---|
| Vercel deploy fails | Roll back via `vercel rollback`; re-enter layer 09 with deploy log as new red feedback. |
| Smoke check shows console errors | Open follow-up Story; do not auto-rollback unless impact severe. |
| Health check returns non-200 | Roll back. |

## Lock-once

The deployment record is lock-once. The merged commit on `main` is normal git history.
