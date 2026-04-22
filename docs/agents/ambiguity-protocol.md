# Ambiguity protocol

**Status: *[TBD]*** — scaffolding only.

What to do when a requested action does not match any Workflow Signal, or when the artifact needed to proceed does not exist.

## Planned contents

- **Walk up the Workflow chain.** If Stage N's named artifact is missing, the session owes Stage N−1 (which produces that artifact), not Stage N. Locate the highest unbuilt stage and report it.
- **Stop, do not improvise.** Never invent an artifact to unblock execution. Invented Stories or Tasks bypass the extraction ceremony and leak variance into Tier 3.
- **Escalate with a specific ask.** When reporting ambiguity, name: the Signal that failed to match, the missing upstream artifact, the stage that owns it, and the human action required to resolve.
- **Never silently edit a locked artifact** as a substitute for escalation — see [`lock-once-discipline.md`](lock-once-discipline.md).

Will be elaborated when the first real ambiguity scenarios surface.
