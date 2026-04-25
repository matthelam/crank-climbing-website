# Session start

What an agent does on session start before taking any action.

## 1. Orient via three routers

In order:

1. **The root [`README.md`](../../README.md)** — Mission Statement, Business Principles, Technology Principles, the Standard Platform table (auto-generated from [`bindings.yaml`](../../bindings.yaml)), and the Workflow table (auto-generated from [`layers/`](../../layers/)).
2. **[`bindings.yaml`](../../bindings.yaml)** — single source of truth for tool selections, version pins, and install methods. **You read this; you do not invent tool choices.**
3. **[`layers/README.md`](../../layers/README.md)** — the 16-layer model the orchestrator traverses.

## 2. Identify your altitude

Are you:

- **The orchestrator?** You are LangGraph; you compose layer subgraphs and decide loop edges. See [`orchestration/`](../../orchestration/).
- **A layer skill?** You execute one layer, invoked by the LangGraph node via the Claude Agent SDK. Find your contract at `layers/XX-{slug}/layer.md`. Your bound tools are derived from [`bindings.yaml`](../../bindings.yaml) capabilities listed under "Bindings used".
- **A reviewer or maintainer?** Cross-cutting work. Read this file plus the four other convention docs in this directory.

## 3. Verify prerequisites before acting

Before producing any layer artifact, confirm:

- The predecessor layer's artifact exists (`gates.yaml` → `entry`).
- Required secrets are present (`infrastructure/secrets/policy.yaml` lists them; check `.env.local`).
- Required tools verify (the bootstrap layer's report should be the most recent file under `intent/bootstrap/`).

If any of these fail, surface the gap immediately rather than improvising.

## 4. Lock-once

Outputs of every layer are immutable. Read [`lock-once-discipline.md`](lock-once-discipline.md) before writing any artifact under `intent/`.
