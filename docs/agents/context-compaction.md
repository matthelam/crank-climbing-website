# Context compaction

**Status: *[TBD]*** — scaffolding only.

What to preserve, summarise, or drop when the context window is compacted.

## Planned contents

- **Always preserve:** the identity of the current Workflow stage, the current intent artifact being executed (Feature / Story / Task ID), and any locked acceptance criteria.
- **Summarise:** exploratory reasoning, tool-output transcripts, intermediate diffs that have already landed.
- **Drop:** reasoning from earlier stages whose outputs are now committed artifacts in the repo — those are re-derivable from disk.
- **Anti-pattern:** preserving raw conversation at the expense of the locked artifact references. If compaction forces a choice, keep the pointer to the intent artifact, not the conversation around it.

Will be elaborated once the repo has concrete intent artifacts to reference.
