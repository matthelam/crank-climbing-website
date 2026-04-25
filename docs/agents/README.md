# docs/agents/

Canonical agent conventions. Platform-specific router files (`CLAUDE.md`, `AGENTS.md`, `.github/copilot-instructions.md`, LangGraph node system prompts) all route here rather than duplicating content — single source of truth, School A.

Scan Signals top-down; the first match names the convention you need.

| Signal | Key | Detail |
|--------|-----|--------|
| Starting a new session; need to orient | **Session start** | [`session-start.md`](session-start.md) *[TBD]* |
| Need to pick the right tool for the current task | **Tool dispatch** | [`tool-dispatch.md`](tool-dispatch.md) *[TBD]* |
| Context window filling; unsure what to keep | **Context compaction** | [`context-compaction.md`](context-compaction.md) *[TBD]* |
| Blocked, ambiguous, or missing an upstream artifact | **Ambiguity protocol** | [`ambiguity-protocol.md`](ambiguity-protocol.md) *[TBD]* |
| Reporting state, referencing a phase, or citing an artifact | **Citation conventions** | [`citation-conventions.md`](citation-conventions.md) *[TBD]* |
| Tempted to edit a locked intent artifact | **Lock-once discipline** | [`lock-once-discipline.md`](lock-once-discipline.md) *[TBD]* |

**Non-duplication rule.** These documents explain *how* to use the repo's routers — they do not copy the routers themselves. The canonical sources stay in the [root README](../../README.md): the Standard Platform table for tool choice, the Workflow table for phase location, the Documentation section for intent navigation.

**Platform-specific entry points.** Each of these contains only what is truly unique to its platform (hooks, slash commands, IDE behaviour) and otherwise routes here:

- [`CLAUDE.md`](../../CLAUDE.md) — Claude Code.
- [`AGENTS.md`](../../AGENTS.md) — generic agent spec per the AGENTS.md convention.
- [`.github/copilot-instructions.md`](../../.github/copilot-instructions.md) — GitHub Copilot.- LangGraph node system prompts under [`orchestration/`](../../orchestration/) reference `docs/agents/` by path in their prompt templates.
