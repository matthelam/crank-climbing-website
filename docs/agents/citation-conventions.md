# Citation conventions

How to reference layers, capabilities, and artifacts when reporting state.

## Layer references

Cite by layer id and short name: `layer 09-recursive-build`. Link to the contract: [`layers/09-recursive-build/layer.md`](../../layers/09-recursive-build/layer.md).

When reporting status: "running layer 09-recursive-build, attempt 2 of 5, retry_within_step loop active."

## Capability references

Cite by capability id from [`bindings.yaml`](../../bindings.yaml), backticked: `` `e2e_test` ``, `` `agent_runtime` ``. The tool name and version are *resolved*, not invented — quote the manifest if relevant: "`e2e_test` resolves to playwright `1.49.0`."

## Artifact references

Cite by file path with line where relevant, rendered as a markdown link:

- `intent/decompositions/example-com-2026-04-25T120000Z.md`
- [`intent/tasks/task-042.md:17`](../../intent/tasks/) when the path exists

Never cite an artifact by its `artifact_id` without also linking the file — the id alone leaves the reader hunting.

## Skill and node references

- Skills: `` `/layer-09-recursive-build` `` linked to [`.claude/skills/layer-09-recursive-build/SKILL.md`](../../.claude/skills/layer-09-recursive-build/SKILL.md).
- Orchestration nodes: linked file path, e.g. [`orchestration/nodes/hitl.py`](../../orchestration/nodes/hitl.py).

## PRs and issues

Always full URL, never bare `#123`. Example: `[apps#33297](https://github.com/anthropics/apps/pull/33297)`. If you don't know the repo URL, resolve it with `gh`.

## Memory references

Reference by title, not file path: "per the [Lock-once intent principle](file://memory) memory" — the harness exposes memory by title, not by location.
