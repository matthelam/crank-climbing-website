---
name: layer-00-bootstrap
description: Provision tools, infra, and accounts on a fresh clone (layer 00). Invoked by orchestration/graphs/layer_00_bootstrap.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 00-bootstrap

This skill executes [layer 00-bootstrap](../../../layers/00-bootstrap/layer.md). Read `layer.md` for purpose, gates, IO schemas, HITL policy, and loop edges.

## Authoritative references

- **Contract:** [`layers/00-bootstrap/layer.md`](../../../layers/00-bootstrap/layer.md)
- **Output schema:** [`layers/00-bootstrap/schema.output.json`](../../../layers/00-bootstrap/schema.output.json)
- **Bindings manifest:** [`bindings.yaml`](../../../bindings.yaml)
- **Subgraph:** [`orchestration/graphs/layer_00_bootstrap.py`](../../../orchestration/graphs/layer_00_bootstrap.py)

## Steps

1. Read `layer.md` for the contract.
2. Resolve every capability listed under "Bindings used" against `bindings.yaml` → use the `ai_binding.tool` and `ai_binding.version`.
3. Read upstream artifacts named in `upstream_refs`.
4. Apply any `overrides` from the input.
5. Produce the lock-once artifact in the location named by the layer's "Outputs" section.
6. Reply with **only the repo-relative path** of the new artifact on the final line of your response.

## Lock-once

Never edit an existing artifact under `intent/`. Revisions produce a new file with `supersedes` set to the prior `artifact_id`.

## Body

*[TBD — per-layer body authored when this layer's vertical slice is implemented.]*
