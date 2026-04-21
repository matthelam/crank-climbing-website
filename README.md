# Crank Climbing Website

This README binds every decision in this repository — business and technology.

## Mission Statement

Crank welcomes everyone into climbing and ninja — a healthy, friendly community where anyone belongs.

## Business Principles

1. **Conversion** — First Time, Memberships, Coaching, Group Bookings, Gift Cards, Contact Us.
2. **Consideration** — Services & Facilities, Operating Times, Events, Community Engagement.
3. **Retention** — Certifications, Membership management, Waivers.

## Technology Principles

Requirements are the only non-deterministic artifact in this repository. Everything else — code, configuration, infrastructure, deployment, tooling — exists as committed artifacts that keep the system fully reproducible. Humans and AI are bound equally; no system state is established by hand. Where no tool-based script exists, a documented step guide is the last-resort fallback, written so a human or browser-driving agent can execute it deterministically.

**Reproducibility is the test, and the mechanism varies by type: code changes are reversed through version control, with no backout logic inside the application; infrastructure and data changes reconcile to declared state or ship with paired forward/backout scripts; irreversible actions are committed as a record of the act.**

User Stories and Tasks are scoped and measured by the deterministic artifacts they produce: a Story or Task is complete only when those artifacts exist in the repository, pass their tests, and are committed.

The next two sections — **Standard Platform** and **Workflow** — are signal→key lookup tables. Scan signals, pick the key, follow the link; unmatched signals are gaps to flag.

### Standard Platform

**Core**
- Building an application page or route → **Next.js**
- Writing typed code → **TypeScript**
- Deploying the application → **Vercel**
- Hosting source + collaboration → **GitHub**
- Running CI on every push → **GitHub Actions**

**Frontend**
- Styling an element → **Tailwind CSS**
- Composing primitives (dialog, menu, tooltip, etc.) → **Radix** via **shadcn/ui**
- Design source of truth → **Figma**

**Quality**
- Verifying UI behaviour end-to-end → **Playwright**
- Enforcing type correctness → **TypeScript strict**
- Verifying non-UI logic → **Vitest**

**AI Tooling**
- Inline code completion while typing → **GitHub Copilot**
- Agent-driven repo operations → **Claude Code**
- Generating UI from a prompt or Figma frame → **v0**
- Looking up framework or Vercel documentation → **Next.js DevTools MCP**, **Vercel MCP**
- Looking up Microsoft / Azure documentation → **Microsoft Docs MCP**
- Inspecting a running page (DOM, network, logs) → **Chrome DevTools MCP**
- Automating a browser (scripted interactions) → **Playwright MCP**

**Operations**
- Measuring site usage → **Vercel Analytics**
- Capturing runtime logs and errors → **Vercel runtime observability**
- Installing and managing dependencies → **npm**

Future capabilities (auth, payments, CMS, richer observability) will be chosen from the **Vercel**, **GitHub**, or **Microsoft** ecosystems. This is the binding constraint — specific tools are selected when the need arises, not speculatively.

### Engineering Practices

- **UI:** Atomic Design for component structure; Playwright for end-to-end testing.
- **Non-UI:** SOLID for module design; Vitest for unit testing.
- **Test-Driven Development:** tests precede code; red → green → refactor; applied recursively so every composed unit is built from already-tested smaller units.

### Workflow

Scan signals top-down; first match is the current phase. Ambiguity means an upstream artifact is incomplete — walk up the chain, resolve, re-enter.

| # | Signal | Key | Detail |
|---|--------|-----|--------|
| 1 | No Scope document exists | **Scope** | *[TBD]* |
| 2 | Scope exists; no Elaboration | **Elaboration** | *[TBD]* |
| 3 | Elaboration exists; no Requirement with goal-level AC | **Requirements** | *[TBD]* |
| 4 | Requirement needs UI; no design Story or Figma source | **UI/UX** *(conditional)* | *[TBD]* |
| 5 | Requirement exists; no decomposed Stories with technical AC | **Stories + Tasks** | *[TBD]* |
| 6 | Story exists; its named test file absent | **Red Tests** | *[TBD]* |
| 7 | Test exists and fails; named artifact absent or incomplete | **Recursive Build** | *[TBD]* |
| 8 | All tests green; type-check / lint / build not run clean | **Local Verification** | *[TBD]* |
| 9 | Clean locally; no PR open for this branch | **Pull Request** | *[TBD]* |
| 10 | PR open with green CI; no verification notes referencing both AC | **Dual-AC Verification** | *[TBD]* |
| 11 | PR verified; not yet approved | **Review** | *[TBD]* |
| 12 | PR approved; not merged / observability not resumed | **Merge + Deploy + Observe** | *[TBD]* |

### Documentation

Requirements, User Stories, and Test Plans live as markdown in a dedicated documentation directory — authored for humans, consumed by agents. Structure and governance: *[TBD]*.

## TODO

Outstanding items as of this revision. Each entry points at the placeholder file where work continues, the parked concept awaiting the right moment, or the open decision to settle.

**Placeholder files to materialise**
- [`CLAUDE.md`](CLAUDE.md) — session-start protocol, tool dispatch, context compaction rules, ambiguity + deviation protocol, citation conventions.
- [`AGENTS.md`](AGENTS.md) — cross-tool agent conventions pointing at the rest.
- [`.claude/settings.json`](.claude/settings.json) — permissions, hooks, model preferences.
- [`.claude/skills/`](.claude/skills/) — custom skills (Agent and Instruction definitions, daisy-chain target from Technology Principles).
- [`.claude/agents/`](.claude/agents/) — subagent definitions when a task warrants one.
- [`.claude/commands/`](.claude/commands/) — custom slash commands for recurring orchestrations.
- [`.github/copilot-instructions.md`](.github/copilot-instructions.md) — Copilot-specific conventions.
- [`.github/pull_request_template.md`](.github/pull_request_template.md) — enforces Phase 10 dual-AC verification.
- [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE/) — intake templates for Scope, Requirement, Story.

**Linked documents still to author**
- Detailed instructions per Standard Platform tool (one document per key).
- Detailed instructions per Workflow phase (one document per phase).
- Documentation directory structure, authoring model, granularity, governance.
- Engineering Practices elaboration if depth grows.

**Parked concepts (introduce when the project needs them)**
- Marketing brand kit — linked document; required input for UI/UX and content work.
- Measurement / success resources — links defining how business outcomes are measured.

**Open decisions**
- Whether to extend the signal→key pattern to Engineering Practices and Documentation for consistency.
- Top-level "done" definition for the project as a whole.
- Sequencing guidance for Stories across the three Business Principles tiers.
