# Crank Climbing Website

This repo is the system's only source of truth. The agent harness is **GitHub Spec Kit + Claude Code**. The constitution at [`.specify/memory/constitution.md`](.specify/memory/constitution.md) is binding.

## Mission

Crank welcomes everyone into climbing and ninja — a healthy, friendly community where anyone belongs.

## Business principles

1. **Conversion** — First Time, Memberships, Coaching, Group Bookings, Gift Cards, Contact Us.
2. **Consideration** — Services & Facilities, Operating Times, Events, Community Engagement.
3. **Retention** — Certifications, Membership management, Waivers.

Every Feature traces to one principle.

## Standard Platform

Closed list. Future capabilities chosen from the **Vercel**, **GitHub**, or **Microsoft** ecosystems unless the constitution is amended.

| Layer | Tool |
|-------|------|
| App framework | Next.js + TypeScript (strict) |
| Styling | Tailwind CSS |
| Primitives | Radix via shadcn/ui |
| Component dev / test | Storybook (+ Storybook MCP, local-only) |
| Non-UI tests | Vitest |
| End-to-end tests | Playwright (+ Playwright MCP) |
| Hosting + deploy | Vercel |
| Source + CI | GitHub + GitHub Actions |
| Design source | Figma |
| Agent harness | Claude Code |
| Orchestration | LangGraph |

How to use each is what 2026 agents already know — the binding signal is the *what*, captured here and in the constitution.

**Version policy.** Pin every tool above to an explicit version (default: latest current stable when not yet picked). No floating ranges. Bumps are deliberate intent changes — lock-once. Detail in the constitution.

## Workflow

Spec Kit owns Stages 1–5; Crank-specific Stages 6–12 live in [`docs/workflow.md`](docs/workflow.md).

| Slash command | Replaces / executes |
|---------------|---------------------|
| [`/speckit.constitution`](.claude/commands/speckit.constitution.md) | Confirm binding constraints before any spec work |
| [`/speckit.specify`](.claude/commands/speckit.specify.md) | Stages 1–3 (Scope → Elaboration → Requirements) → `specs/[id]/spec.md` |
| [`/speckit.plan`](.claude/commands/speckit.plan.md) | Stage 4 + Standard Platform tool selection → `specs/[id]/plan.md` |
| [`/speckit.tasks`](.claude/commands/speckit.tasks.md) | Stage 5 (Stories + Tasks) → `specs/[id]/tasks.md` |
| [`/speckit.implement`](.claude/commands/speckit.implement.md) | Stages 6–8 (Red Tests → Recursive Build → Local Verification) |

Stages 9–12 (PR → Dual-AC → Review → Merge+Deploy+Observe) run by hand against [`docs/workflow.md`](docs/workflow.md).

## Test ladder (the discipline)

The non-obvious rule the constitution enforces:

- **Story = component** → tested in **Storybook** (functionality, theme, W3C a11y).
- **Feature = business process** → tested in **Playwright** end-to-end.
- **Non-UI** → **Vitest**.
- **Storybook-green precedes Playwright-green; never the reverse.** A Playwright failure against an unverified component cannot be localized.

## Lock-once

Specs, plans, and task lists committed under `specs/` are immutable post-merge. Changes produce a superseding spec under a new feature ID; the prior is archived, not edited.

## Next

Author the first Feature: `/speckit.constitution` then `/speckit.specify <feature-id> "<problem>"`. The system has no work to execute against until at least one spec exists.
