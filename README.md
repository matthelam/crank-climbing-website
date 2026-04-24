# Crank Climbing Website

This repo is the system's only source of truth.

## Mission

Crank welcomes everyone into climbing and ninja — a healthy, friendly community where anyone belongs.

## Business principles

1. **Conversion** — First Time, Memberships, Coaching, Group Bookings, Gift Cards, Contact Us.
2. **Consideration** — Services & Facilities, Operating Times, Events, Community Engagement.
3. **Retention** — Certifications, Membership management, Waivers.

Every Feature traces to one principle.

## Standard Platform

Closed list. Future capabilities chosen from the **Vercel**, **GitHub**, or **Microsoft** ecosystems unless this list is amended.

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

The binding signal is the *what* — the closed list above. The *how* is what 2026 agents already know.

**Version policy.** Pin every tool above to an explicit version (default: latest current stable when not yet picked). No floating ranges. Bumps are deliberate intent changes — lock-once.

## Workflow

Twelve stages — see [`docs/workflow.md`](docs/workflow.md). Walk top-down; first signal that fires is the current stage.

| # | Signal | Stage |
|---|--------|-------|
| 1 | No Scope document exists | Scope |
| 2 | Scope exists; no Elaboration | Elaboration |
| 3 | Elaboration exists; no Requirement with goal-level AC | Requirements |
| 4 | Requirement needs UI; no design Story or Figma source | UI/UX (conditional) |
| 5 | Requirement exists; no decomposed Stories with technical AC | Stories + Tasks |
| 6 | Story exists; its named test file absent | Red Tests |
| 7 | Test exists and fails; named artifact absent or incomplete | Recursive Build |
| 8 | All tests green; type-check / lint / build not run clean | Local Verification |
| 9 | Clean locally; no PR open for this branch | Pull Request |
| 10 | PR open with green CI; no verification notes referencing both AC | Dual-AC Verification |
| 11 | PR verified; not yet approved | Review |
| 12 | PR approved; not merged / observability not resumed | Merge + Deploy + Observe |

## Test ladder (the discipline)

The non-obvious sequencing rule:

- **Story = component** → tested in **Storybook** (functionality, theme application, W3C accessibility).
- **Page-assembly Story** → declares dependencies on its Component Stories; rendered in Storybook for composition + theme integrity, but not page-level behaviour.
- **Feature = business process** → tested in **Playwright** end-to-end against the assembled product.
- **Non-UI work** → **Vitest**.
- **Storybook-green precedes Playwright-green; never the reverse.** A Playwright failure against an unverified component cannot be localized.

## Engineering practices

- **UI:** Atomic Design for component structure.
- **Non-UI:** SOLID for module design.
- **TDD:** Red → Green → Refactor, applied recursively. Never compose an untested unit into a tested one.

## Lock-once

Scope, Elaboration, Requirement, Story, Task, and merged commits are immutable. Changes produce superseding artifacts under new identifiers; the prior is archived, not edited. This is what makes Stage 10 dual-AC verification auditable.

## Intent artifacts

Authored under `intent/features/`, `intent/stories/`, `intent/tasks/` — none exist yet. The first Feature unblocks Stages 5+; until then the workflow stalls at decomposition.
