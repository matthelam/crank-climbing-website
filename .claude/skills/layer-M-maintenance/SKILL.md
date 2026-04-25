---
name: layer-M-maintenance
description: Detect drift between declared bindings/infra state and reality; propose superseding entries. Invoked weekly by .github/workflows/maintenance.yml or on demand via the orchestrator.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
shell: powershell
disable-model-invocation: true
---

# Layer M — Maintenance

Detect drift in declared state and propose supersedes. **This layer reports — it does not converge.** Convergence happens when a human merges the proposal PR, which then triggers a re-run of `00-bootstrap`.

**Contract:** [`layers/M-maintenance/layer.md`](../../../layers/M-maintenance/layer.md).

## Steps

1. **Load declared state.** Read [`bindings.yaml`](../../../bindings.yaml) and every file under [`infrastructure/`](../../../infrastructure/) that has a corresponding `_schemas/*.schema.json`.
2. **Compare bindings to upstream.** For each capability with `install.method` in {`winget`, `npm`, `pip`, `vendor`, `github_release`}:
   - Resolve the latest stable version upstream:
     - `winget`: `winget show --id <package> --source winget` and parse Version field.
     - `npm`: `npm view <package> version`.
     - `pip`: `python -m pip index versions <package>` or query PyPI JSON.
     - `vendor`/`github_release`: `gh api repos/<owner>/<repo>/releases/latest --jq .tag_name`.
   - Compare against `ai_binding.version`. If newer stable exists and `last_checked` is older than 7 days, flag as drift.
3. **Compare infrastructure to live state.**
   - GitHub repo: `gh repo view --json name,visibility,defaultBranchRef,...` — diff against `infrastructure/github/repo.yaml`.
   - Vercel project: `vercel project ls --token $env:VERCEL_TOKEN` — diff against `infrastructure/vercel/project.yaml`.
   - MCP servers: `claude mcp list --json` — diff against `infrastructure/mcp/servers.yaml`.
4. **Write the drift report.** `intent/maintenance-runs/{ISO-timestamp}.md` listing every flagged drift with: capability or infra entry, declared value, observed value, suggested supersede.
5. **If any drift found, write a proposal.** Generate `bindings.yaml.proposal` (and analogous `.proposal` files under `infrastructure/`) with the suggested supersedes applied. Each capability gets `last_checked` updated and `supersedes: <old-capability-id>` if structurally renamed.
6. **Open a PR.** `gh pr create --title "Maintenance: drift report YYYY-MM-DD" --body-file intent/maintenance-runs/{ts}.md` against the default branch, labelled `layer/scaffold`.
7. **Reply with the report path.** Final line.

## What this skill does NOT do

- Apply changes directly to `bindings.yaml` or `infrastructure/`. Convergence happens via human-merged PR.
- Change application source under [`src/`](../../../src/).
- Run any layer other than itself.

## Failure modes

| Failure | Recovery |
|---|---|
| Upstream registry unreachable | Skip that capability; note in the report; do not block other checks. |
| `gh` or `vercel` CLI not authenticated | Surface clear error; the workflow's secrets are missing. |
| Proposal already open against default branch | Update existing PR rather than opening a duplicate. |
