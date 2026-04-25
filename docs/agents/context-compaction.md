# Context compaction

What to preserve, summarise, or drop when the context window is compacted.

## Always preserve

- **Current layer id** (e.g., `09-recursive-build`) and the artifact id you are producing.
- **Pointers to locked artifacts** under `intent/` referenced by the current layer's `upstream_refs`. Pointers are short and cheap; the file content is re-derivable.
- **Current `bindings.yaml` state** for the capabilities your layer uses (tool name, version pin). If those bindings change mid-conversation, the layer must re-enter from the top.
- **HITL decisions made this run** (approved / rejected) — these affect supersede behaviour.

## Summarise

- Exploratory reasoning that produced the current artifact.
- Tool-output transcripts (CLI output, MCP responses) once their conclusions have been written into an artifact.
- Failed attempts inside a `retry_within_step` loop — keep the latest failure, drop earlier ones.

## Drop

- Reasoning from layers earlier in the chain. Their outputs are committed locked-once artifacts on disk; re-derive from disk if needed.
- Conversation around superseded artifacts. The supersede is the new truth.

## Anti-patterns

- Preserving raw conversation at the expense of locked artifact references. If forced to choose, keep the pointer.
- Re-summarising already-summarised content (compaction churn). Summaries should be terminal — re-derive from disk if you need the detail back.
