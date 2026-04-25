# Layer M — Maintenance

**Status:** active. Scheduled execution wired in [`.github/workflows/maintenance.yml`](../../.github/workflows/maintenance.yml).

**Purpose.** Detect drift between declared state ([`bindings.yaml`](../../bindings.yaml), [`infrastructure/`](../../infrastructure/)) and reality. Propose superseding bindings/IaC entries when newer stable versions exist or external state has drifted.

**Position.** Out-of-band. Runs on a weekly schedule via [`.github/workflows/maintenance.yml`](../../.github/workflows/maintenance.yml) and on demand. Does not gate any other layer.

## Inputs

- Current `bindings.yaml`.
- Current `infrastructure/*.yaml`.
- Live state from `gh`, `vercel`, `npm view`, package registries, MCP server registries.

## Outputs

- `intent/maintenance-runs/{timestamp}.md` — drift report.
- `bindings.yaml.proposal` — superseding manifest (if changes recommended).
- A PR opened against the default branch with the proposal.

## Bindings used

- `source_hosting`
- `hosting`
- `package_manager`
- `agent_runtime`
- `agent_sdk`
- `orchestrator`

## Gates

- **Entry:** scheduled trigger fires, or manually invoked.
- **Exit:** drift report committed; if changes proposed, PR open.

## HITL policy

`optional` — review happens when the human reviews the proposal PR.

## Loop edges

- None — this layer reports, it does not converge. Convergence happens by merging the proposal, which then triggers `00-bootstrap` to pull the new state.

## Skill

[`/layer-M-maintenance`](../../.claude/skills/layer-M-maintenance/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_M_maintenance.py`](../../orchestration/graphs/layer_M_maintenance.py)
