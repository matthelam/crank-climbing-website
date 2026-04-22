# Tool dispatch

**Status: *[TBD]*** — scaffolding only.

How to pick the right tool for a given task. The authoritative router is the **Standard Platform** table in the [root `README.md`](../../README.md) — do not duplicate it here.

## Planned contents

- How to read a Signal row: match the Signal to the current task, use the Key, follow the Detail link.
- **Pattern A boundary.** LangGraph orchestrates; Claude Code executes. Extraction gates, verification routing, and approval flow belong in LangGraph nodes — not in Claude Code skills, agents, or commands. If a workflow gate needs deterministic routing, the answer is "that belongs in a LangGraph node."
- What to do when no Signal matches: escalate to the ambiguity protocol, do not improvise a tool choice.
- Speculative-tool rule: the README forbids speculative additions to the Standard Platform. New tools are selected when the need arises, drawn from the Vercel, GitHub, or Microsoft ecosystems.

This document will elaborate once the first concrete dispatch scenarios are authored.
