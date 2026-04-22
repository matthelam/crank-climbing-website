# Crank Climbing Website

This README binds every decision in this repository — business and technology.

## Mission Statement

Crank welcomes everyone into climbing and ninja — a healthy, friendly community where anyone belongs.

## Business Principles

1. **Conversion** — First Time, Memberships, Coaching, Group Bookings, Gift Cards, Contact Us.
2. **Consideration** — Services & Facilities, Operating Times, Events, Community Engagement.
3. **Retention** — Certifications, Membership management, Waivers.

## Technology Principles

This repository holds every aspect of the system — it is the system's only source of truth. Artifacts must be informed by Requirements and delivered as deterministic, committed artifacts. The test: can the collective artifacts within this repository rebuild or restore every aspect of the system?

Detailed mechanisms — intent vs. delivery artifacts, per-type reproducibility, completion definitions — live in [`docs/technology/reproducibility.md`](docs/technology/reproducibility.md) *[TBD]*.

### Standard Platform

Use the Standard Platform as a tool router. The Signal is the task that needs action; the Key is the technology you must use to deliver on the action; the Detail is the link to how to use the technology.

| Category | Signal | Key | Detail |
|----------|--------|-----|--------|
| Core | Building an application page or route | **Next.js** | *[TBD]* |
| Core | Writing typed code | **TypeScript** | *[TBD]* |
| Core | Deploying the application | **Vercel** | *[TBD]* |
| Core | Hosting source + collaboration | **GitHub** | *[TBD]* |
| Core | Running CI on every push | **GitHub Actions** | *[TBD]* |
| Frontend | Styling an element | **Tailwind CSS** | *[TBD]* |
| Frontend | Composing primitives (dialog, menu, tooltip, etc.) | **Radix** via **shadcn/ui** | *[TBD]* |
| Frontend | Design source of truth | **Figma** | *[TBD]* |
| Quality | Verifying UI behaviour end-to-end | **Playwright** | *[TBD]* |
| Quality | Enforcing type correctness | **TypeScript strict** | *[TBD]* |
| Quality | Verifying non-UI logic | **Vitest** | *[TBD]* |
| AI Tooling | Inline code completion while typing | **GitHub Copilot** | *[TBD]* |
| AI Tooling | Agent-driven repo operations | **Claude Code** | *[TBD]* |
| AI Tooling | Generating UI from a prompt or Figma frame | **v0** | *[TBD]* |
| AI Tooling | Looking up framework or Vercel documentation | **Next.js DevTools MCP**, **Vercel MCP** | *[TBD]* |
| AI Tooling | Looking up Microsoft / Azure documentation | **Microsoft Docs MCP** | *[TBD]* |
| AI Tooling | Inspecting a running page (DOM, network, logs) | **Chrome DevTools MCP** | *[TBD]* |
| AI Tooling | Automating a browser (scripted interactions) | **Playwright MCP** | *[TBD]* |
| Operations | Measuring site usage | **Vercel Analytics** | *[TBD]* |
| Operations | Capturing runtime logs and errors | **Vercel runtime observability** | *[TBD]* |
| Operations | Installing and managing dependencies | **npm** | *[TBD]* |

Future capabilities (auth, payments, CMS, richer observability) will be chosen from the **Vercel**, **GitHub**, or **Microsoft** ecosystems. This is the binding constraint — specific tools are selected when the need arises, not speculatively.

### Engineering Practices

- **UI:** Atomic Design for component structure; Playwright for end-to-end testing.
- **Non-UI:** SOLID for module design; Vitest for unit testing.
- **Test-Driven Development:** tests precede code; red → green → refactor; applied recursively so every composed unit is built from already-tested smaller units.

### Workflow

Use the Workflow to determine where the requested action exists. Scan Signals top-down; the first match is the current stage. The Key names the stage; the Detail is the link to understand that stage. When ambiguity surfaces, walk up the chain to the stage that owns the missing artifact.

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

Requirements, User Stories, and Test Plans live as markdown in a dedicated documentation directory — authored for humans, consumed by agents. These are intent artifacts in natural language; they inform the deterministic delivery artifacts produced downstream. Structure and governance: *[TBD]*.

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
- [`docs/technology/reproducibility.md`](docs/technology/reproducibility.md) — per-type reproducibility mechanisms, intent vs. delivery artifact distinction, Story/Task completion definition, no-backout-in-application rule.
- Detailed instructions per Standard Platform tool (one document per Key).
- Detailed instructions per Workflow stage (one document per stage).
- Documentation directory structure, authoring model, granularity, governance.
- Engineering Practices elaboration if depth grows.

**Parked concepts (introduce when the project needs them)**
- Marketing brand kit — linked document; required input for UI/UX and content work.
- Measurement / success resources — links defining how business outcomes are measured.

**Open decisions**
- Whether to extend the signal→key pattern to Engineering Practices and Documentation for consistency.
- Top-level "done" definition for the project as a whole.
- Sequencing guidance for Stories across the three Business Principles tiers.
