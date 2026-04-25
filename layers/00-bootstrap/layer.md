# Layer 00 — Bootstrap

**Status:** active. Implementation lives in [`scripts/bootstrap.ps1`](../../scripts/bootstrap.ps1).

**Purpose.** Converge the local environment, repository, and external accounts to the declared state in [`bindings.yaml`](../../bindings.yaml) and [`infrastructure/`](../../infrastructure/). After this layer succeeds, every other layer has the prerequisites it needs.

**Position.** Layer 00. Predecessor: none. Successor: `01-business-decomposition`.

## Inputs

- [`bindings.yaml`](../../bindings.yaml) — capability → tool + install pins.
- [`infrastructure/vm/tooling.yaml`](../../infrastructure/vm/tooling.yaml) — required CLIs and runtimes.
- [`infrastructure/mcp/servers.yaml`](../../infrastructure/mcp/servers.yaml) — required MCP servers.
- [`infrastructure/agent/skills.yaml`](../../infrastructure/agent/skills.yaml) — required Claude Code skills/subagents/commands.
- [`infrastructure/github/repo.yaml`](../../infrastructure/github/repo.yaml) — declared GitHub repo state.
- [`infrastructure/vercel/project.yaml`](../../infrastructure/vercel/project.yaml) — declared Vercel project state.
- [`infrastructure/secrets/policy.yaml`](../../infrastructure/secrets/policy.yaml) — required secret names.

## Outputs

- `intent/bootstrap/{timestamp}.md` — bootstrap report: which tools were installed/verified, drift detected, secrets prompted for, post-install actions still required.

## Bindings used

All capabilities with a non-`manual` install method.

## Gates

- **Entry:** running on Windows.
- **Exit:** every required tool verifies; every required secret present in `.env.local`; bootstrap report committed.

## HITL policy

`required` — first run on a fresh VM always reports back to the human before any other layer executes.

## Loop edges

- `retry_within_step`: install_command_failed → re-run with `-Force` (max 2 attempts).
- `re_enter_phase`: bindings_yaml_changed → bootstrap re-runs to converge.

## Skill

[`/layer-00-bootstrap`](../../.claude/skills/layer-00-bootstrap/SKILL.md)

## Subgraph

[`orchestration/graphs/layer_00_bootstrap.py`](../../orchestration/graphs/layer_00_bootstrap.py)
