---
name: layer-template
description: Canonical template for a layer skill. Copied by scripts/generate-skills.ps1 when a new layer is added. Body should be replaced with the layer-specific instructions.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer XX — {Layer Name}

This skill is invoked by [`orchestration/graphs/layer_XX_{slug}.py`](../../../orchestration/graphs/) via the Claude Agent SDK. It is *not* invoked by the model autonomously (`disable-model-invocation: true`).

## Authoritative source

Read [`layers/XX-{slug}/layer.md`](../../../layers/) for purpose, gates, IO schemas, HITL policy, and loop edges. This SKILL.md is the operational instruction; layer.md is the contract.

## Inputs

The orchestration node passes:

```json
{
  "upstream_refs": [{"layer": "...", "artifact_path": "..."}],
  "overrides": { ... }
}
```

## Steps

1. Read [`bindings.yaml`](../../../bindings.yaml) and resolve the capabilities listed in `layer.md` → "Bindings used".
2. Read each upstream artifact path.
3. Apply any overrides from the input.
4. Produce the layer's lock-once artifact (see `layers/XX-{slug}/schema.output.json` for shape).
5. Write the artifact to `intent/{type}/{slug}-{ISO-timestamp}.md` (use `Get-Date -AsUTC -Format "yyyy-MM-ddTHHmmssZ"`).
6. Reply with **only the repo-relative path of the new artifact**, on the last line of the response. The orchestration node parses the last line as the artifact path.

## Output contract

A markdown file with YAML frontmatter:

```markdown
---
artifact_id: {slug}-{timestamp}
layer: XX-{slug}
produced_at: {ISO-8601}
supersedes: null
upstream_refs: [{layer, artifact_id}]
body:
  # layer-specific payload that validates against schema.output.json
---

# Human-readable body
```

## Lock-once

NEVER edit an existing artifact under `intent/`. Always produce a new file. If revising a prior artifact, set `supersedes` to its `artifact_id` and write a new file.
