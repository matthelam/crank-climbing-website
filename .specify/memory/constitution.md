# Crank Climbing Website — Constitution

This is the project constitution loaded by the Spec Kit `/speckit.*` workflow. Principles below are immutable: changes produce new principles, not edits to existing ones (lock-once).

## Mission

Crank welcomes everyone into climbing and ninja — a healthy, friendly community where anyone belongs.

## Business principles

1. **Conversion** — First Time, Memberships, Coaching, Group Bookings, Gift Cards, Contact Us.
2. **Consideration** — Services & Facilities, Operating Times, Events, Community Engagement.
3. **Retention** — Certifications, Membership management, Waivers.

Every Feature traces to one principle. Specs that cannot trace fail `/speckit.analyze`.

## Standard Platform (binding)

The repo is a closed platform — these are the only tools approved for use. Future additions are constrained to the **Vercel**, **GitHub**, or **Microsoft** ecosystems unless a principle exception is recorded here.

| Layer | Tool |
|-------|------|
| App framework | Next.js + TypeScript (strict) |
| Styling | Tailwind CSS |
| Primitives | Radix via shadcn/ui |
| Component dev/test | Storybook (+ Storybook MCP, local-only) |
| Non-UI tests | Vitest |
| End-to-end tests | Playwright (+ Playwright MCP) |
| Hosting + deploy | Vercel |
| Source + CI | GitHub + GitHub Actions |
| Design source | Figma |
| Agent harness | Claude Code |
| Orchestration | LangGraph |

Detail per tool: [`docs/technology/`](../../docs/technology/).

## Test ladder (binding sequencing rule)

This is the core discipline that distinguishes Crank from generic spec-driven development:

1. **Story = component.** A Story is a UI unit testable in isolation in **Storybook** — functionality, theme application, W3C accessibility. A Story may declare dependencies on other Stories (page-assembly = Story whose deps are Component Stories).
2. **Feature = business process.** Tested in **Playwright** end-to-end against the assembled product.
3. **Non-UI work = Vitest.**
4. **Storybook-green precedes Playwright-green; never the reverse.** A Playwright failure against an unverified component cannot be localized. Recursive Build (the implementation phase of `/speckit.implement`) follows this ladder strictly.

## Lock-once

Specs, plans, and task lists committed to `specs/[feature-id]/` are immutable post-merge. Changes produce a superseding spec under a new feature ID; the prior spec is archived, not edited. This is what makes Stage 10 dual-AC verification auditable.

## Engineering practices

- **UI:** Atomic Design for component structure.
- **TDD:** Red → Green → Refactor, applied recursively. Never compose an untested unit into a tested one.
- **Reproducibility:** This repo is the system's only source of truth — every artifact (intent, code, infra) is committed.

## Workflow mapping (Spec Kit ↔ Crank stages)

Spec Kit replaces Crank's Workflow Stages 1–5 (Scope → Stories+Tasks). Stages 6–12 remain Crank-specific because they encode the test ladder above.

| Spec Kit phase | Crank workflow stage |
|----------------|----------------------|
| `/speckit.constitution` | (this file) — replaces ad-hoc principle scattering |
| `/speckit.specify` | Stages 1–3 (Scope → Elaboration → Requirements) |
| `/speckit.plan` | Stage 4 (UI/UX where applicable) + Standard Platform tool routing |
| `/speckit.tasks` | Stage 5 (Stories + Tasks) — Story-as-component, dependencies declared |
| `/speckit.implement` | Stages 6–8 (Red Tests → Recursive Build → Local Verification) |
| (no Spec Kit equivalent) | Stages 9–12 (PR → Dual-AC → Review → Merge+Deploy+Observe) |

Stage detail: [`docs/workflow/`](../../docs/workflow/).
