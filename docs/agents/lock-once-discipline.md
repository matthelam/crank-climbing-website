# Lock-once discipline

**Status: *[TBD]*** — scaffolding only.

Tier 3 intent artifacts (Features, Stories, Tasks) are immutable once extracted and committed. This page enumerates the discipline that makes the lock safe.

## Planned contents

- **Never silently edit a locked artifact.** Execution failure, test failure, or newly-surfaced unknowns are not reasons to modify a committed Task.
- **Raise a new Insight** (in the external Tier 2 surface — Notion) when reality diverges from an intent artifact. The Insight passes through its own extraction ceremony and may produce a **superseding** Task.
- **PR hygiene.** A PR that modifies existing intent files (rather than adding new ones) should be challenged at review. New intent lives under `intent/` with a new artifact ID.
- **Why.** The extraction ceremony is the one place humans absorb AI interpretation variance. If intent can drift after lock, the variance re-opens downstream and makes agent execution unsafe.

See also: [`ambiguity-protocol.md`](ambiguity-protocol.md) for what to do instead of editing.
