# intent/

Tier 3 artifacts — binding specification for what must be built. Schema-conformant, lock-once, agent-executable.

See the [README Documentation section](../README.md#documentation) for the full Signal / Key / Detail navigation.

| Subdirectory | Contains |
|---|---|
| [`schemas/`](schemas/) | JSON schemas governing Feature, Story, Task artifacts. |
| [`features/`](features/) | Feature markdown files. |
| [`stories/`](stories/) | Story markdown files — user-facing behaviour with acceptance criteria. |
| [`tasks/`](tasks/) | Task markdown files — the next executable unit of work. |

Every artifact carries a `source_ref` field pointing at its upstream Tier 2 Insight chunk. The chunks themselves live outside this repo (Notion).

Intent is **locked** once authored. Reality-divergence produces a superseding artifact, not an edit.
