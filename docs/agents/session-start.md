# Session start

**Status: *[TBD]*** — scaffolding only.

What an agent does on session start before taking any action.

## Planned contents

- Read the [root `README.md`](../../README.md) — binds every decision.
- Scan the **Workflow** table (`README.md` → Workflow) top-down; the first Signal that matches the current state names the stage the session sits in.
- Self-locate against the **Standard Platform** table before reaching for a tool — the Key column is the router.
- Check the **Documentation** section for the intent artifact governing the current task; only act on locked artifacts.

This document will elaborate the above into a concrete protocol. Until then, apply the spirit: read before acting, route through the tables, never invent a stage or tool not named in the router.
