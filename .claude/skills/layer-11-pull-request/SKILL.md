---
name: layer-11-pull-request
description: Open the PR for this Story slice (layer 11). Invoked by orchestration/graphs/layer_11_pull_request.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 11 — Pull Request

Open the PR with title, summary, dual-AC checklist, and references to originating Stories/Features.

**Contract:** [`layers/11-pull-request/layer.md`](../../../layers/11-pull-request/layer.md). **Schema:** [`layers/11-pull-request/schema.output.json`](../../../layers/11-pull-request/schema.output.json).

## Steps

1. Read verification report from `10` (must be all-pass).
2. Identify Stories + Tasks touched by the working tree (compare HEAD vs origin/main).
3. Push the current branch if not on origin: `git push -u origin HEAD`.
4. Open the PR via `gh pr create`:
   - Title: `<short imperative>` (under 70 chars).
   - Body: Summary, Test plan, dual-AC checklist (Story-AC + Feature-AC stubs from `06`/`07`).
5. Apply labels: `layer/scaffold` for scaffold-only, otherwise the relevant `layer/XX-...` and `type/feature|fix|refactor`.
6. Write `intent/pull-requests/{pr-number}-{ISO-timestamp}.md` recording PR number, URL, listed Stories, dual-AC stubs.
7. Reply with the PR record path on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| `gh pr create` fails due to existing PR | Update existing PR (`gh pr edit`) instead of opening a duplicate. |
| Branch not pushable (protected) | Surface; this is a config issue in `infrastructure/github/repo.yaml`. |

## Lock-once

PR records are lock-once. PR comments and reviews are normal mutable artifacts.
