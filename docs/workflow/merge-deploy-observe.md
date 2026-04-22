# Stage 12: Merge + Deploy + Observe

Detail page for the Workflow **Merge + Deploy + Observe** row — Signal: "PR approved; not merged / observability not resumed".

## Purpose

The Workflow does not end at merge. Merge triggers deploy; deploy triggers observability; observability closes the loop by confirming the deployed change behaves in Production as it did in Preview. If observability does not resume, the Workflow has produced a change that is invisible in Production — and invisible changes cannot be trusted.

This stage exists because Production is the only environment that runs under real traffic, real data, and real users. Local verification, CI, Preview verification — all are proxies. Production is ground truth. Observability is how ground truth becomes measurable.

The exit condition is not merge. It is **observability resumed** — the deployed change is under active watch for a defined window, with a clear rollback path if signals regress.

## Enter / Exit

- **Enter when:** PR is approved; not yet merged, or observability has not resumed on the merged change.
- **Exit when:** PR is merged to `main`, Vercel has deployed to Production, and observability signals (logs, analytics, errors, Core Web Vitals) are under active watch.

## Rule

A merge is not complete until the deployed change is under active observation. The exit is observability resumption, not merge itself. If signals regress during the watch window, open a **superseding** PR (not a revert); return to [Stage 7](recursive-build.md) or earlier as the failure warrants.

## Artifact produced

- Merged commit on `main`.
- Production deployment on Vercel.
- Observability signals flowing — runtime logs, analytics events, Core Web Vitals, error rate.

## Merge discipline (suggested)

Squash to a single commit per PR. Commit message includes the PR number and links the Story.

## Post-deploy watch (suggested)

Active watch window: 15–60 minutes for routine changes, longer for high-risk changes (auth, payments, migrations).

**Active watch** means:
- Vercel runtime logs streaming (`vercel logs --follow`, or the Observability tab).
- Vercel Analytics dashboard open for the affected funnel.
- Speed Insights open for Core Web Vitals regression.
- Error alerts armed (if configured).

## Standard Platform tools

| Tool | When to reach for it at this stage |
|------|------------------------------------|
| [GitHub](../technology/github.md) | Merge action, post-merge commit trail. |
| [GitHub Actions](../technology/github-actions.md) | Final CI gate on the merge commit. |
| [Vercel](../technology/vercel.md) | Git integration auto-deploys `main` to Production; `vercel --prod` available for manual/CI paths. |
| [Vercel runtime observability](../technology/vercel-runtime-observability.md) | Tail runtime logs; watch for new errors post-deploy. |
| [Vercel Analytics](../technology/vercel-analytics.md) | Confirm user-facing AC continues to land (conversion events, custom events); watch Core Web Vitals via Speed Insights. |
| [Vercel MCP](../technology/vercel-mcp.md) | Programmatic access to runtime logs and deployment state during watch. |
| [Chrome DevTools MCP](../technology/chrome-devtools-mcp.md) | Smoke-check Production behavior immediately post-deploy (Lighthouse, performance trace). |
| [Playwright MCP](../technology/playwright-mcp.md) | Re-run critical E2E flows against Production for post-deploy smoke. |
| [Microsoft Docs MCP](../technology/microsoft-docs-mcp.md) | If the change touches Microsoft/Azure platform dependencies, verify post-deploy behavior against docs. |

## Agent protocol

1. Confirm approval (Stage 11 exit).
2. Merge the PR. Vercel auto-deploys `main` to Production.
3. Wait for the Production deployment to go live.
4. Immediately post-deploy: tail runtime logs for new errors (Vercel runtime observability).
5. For UI changes: exercise the Production URL via Chrome DevTools MCP or Playwright MCP; confirm behavior matches Preview verification.
6. For analytics-bound AC: watch Vercel Analytics to confirm events continue to land.
7. Hold the watch for the configured window. If clean, the Workflow is complete.
8. If signals regress, open a superseding PR and return to [Stage 7](recursive-build.md) or earlier.
