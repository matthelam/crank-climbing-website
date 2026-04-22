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
| AI Tooling | Orchestrating multi-step agent workflows (extraction ceremonies, verification gates) | **LangGraph** | *[TBD]* |
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

Intent artifacts — Features, Stories, Tasks — live as markdown under [`intent/`](intent/), authored for humans and consumed by agents. Upstream design sources (Figma, Notion, and similar) and downstream delivery artifacts are out of scope for this directory; only intent lives here. Intent is locked once authored: changes produce new artifacts, not edits to old ones. Reference material and per-tool how-to live separately under [`docs/`](docs/) — that directory has a different, revisable lifecycle.

Directory structure. Functional map for agent navigation, not a cosmetic tree. Binding specification lives under [`intent/`](intent/); reference reading lives under [`docs/`](docs/) — different lifecycles, different rules.

| Path | Contains | When to read |
|------|----------|--------------|
| [`intent/schemas/`](intent/schemas/) *[TBD]* | JSON schemas for intent artifacts | Before authoring or validating any Feature, Story, or Task |
| [`intent/features/`](intent/features/) *[TBD]* | Feature markdown files | When scoping work or identifying a parent for a Story |
| [`intent/stories/`](intent/stories/) *[TBD]* | Story markdown files | When decomposing into Tasks or writing Red Tests |
| [`intent/tasks/`](intent/tasks/) *[TBD]* | Task markdown files | When implementing, referencing in PRs or commits |
| [`docs/technology/`](docs/technology/) | Per-tool and per-stage reference docs, one-off technical sketches | When a Standard Platform or Workflow link resolves here |
| [`orchestration/`](orchestration/) | LangGraph graph definitions; Crank cognitive-profile roster | When authoring or running an agent workflow (extraction, verification, approval) |
| [`infrastructure/`](infrastructure/) *[TBD]* | Deployment and environment configuration; IaC when it lands | When changing deployment behaviour or environment setup |
| [`src/`](src/) *[TBD]* | Application source | When implementing a Task that produces code |

Documents. Scan Signals top-down; the first match names the artifact type you need.

| Signal | Key | Detail |
|--------|-----|--------|
| Need to understand what we're building at scope level | **Feature** | [`intent/features/`](intent/features/) *[TBD]* |
| Need user-facing behaviour with acceptance criteria | **Story** | [`intent/stories/`](intent/stories/) *[TBD]* |
| Need the next executable unit of work | **Task** | [`intent/tasks/`](intent/tasks/) *[TBD]* |
| Need to validate or author an intent artifact | **Schema** | [`intent/schemas/`](intent/schemas/) *[TBD]* |

Schemas. The schema layer made navigable; each Key points at the JSON file that governs that artifact type.

| Signal | Key | Detail |
|--------|-----|--------|
| Authoring or validating a Feature | **`feature.schema.json`** | [`intent/schemas/feature.schema.json`](intent/schemas/feature.schema.json) *[TBD]* |
| Authoring or validating a Story | **`story.schema.json`** | [`intent/schemas/story.schema.json`](intent/schemas/story.schema.json) *[TBD]* |
| Authoring or validating a Task | **`task.schema.json`** | [`intent/schemas/task.schema.json`](intent/schemas/task.schema.json) *[TBD]* |

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

**Linked documents still to author** *(ordered by load-bearing weight)*
- [`docs/technology/reproducibility.md`](docs/technology/reproducibility.md) — the most load-bearing unresolved piece. Defines per-type reproducibility mechanisms, the intent vs. delivery artifact distinction, Story/Task completion criteria, and the no-backout-in-application rule. Anchors the four-tier knowledge flow (Raw Notes → Insights → Intent → Delivery), names the extraction ceremony as a human-gated ritual that happens outside the repo, and makes the lock-once principle testable.
- Intent schemas in [`intent/schemas/`](intent/schemas/) — `feature.schema.json`, `story.schema.json`, `task.schema.json`. The extraction contract: schema shape determines upstream chunk taxonomy. Includes the `source_ref` field that pins each artifact to its upstream extraction source.
- Seed documents under [`intent/`](intent/) — first Feature, Story, and Task once authoring governance is settled.
- Extraction-ceremony graph under [`orchestration/graphs/`](orchestration/) — a LangGraph state machine governing how Tier 2 Insights promote into Tier 3 intent artifacts. First concrete consumer of the Cognitive Profile Compiler's output.
- Crank agent roster under [`orchestration/profiles/`](orchestration/) — cognitive profiles per altitude band (Executor through Principal) and per concern lens (Security, Performance, Accessibility).
- Detailed instructions per Standard Platform tool (one document per Key).
- Detailed instructions per Workflow stage (one document per stage).
- Engineering Practices elaboration if depth grows.

**Parked concepts (introduce when the project needs them)**
- Marketing brand kit — linked document; required input for UI/UX and content work.
- Measurement / success resources — links defining how business outcomes are measured.
- Cognitive Profile Compiler — a separate repository that translates 12-dimension cognitive profiles into LangGraph node configurations. Crank is a downstream consumer, not an owner.
- Semantic router / intent-classified content map — Azure AI Search-based architecture for LLM-at-the-front intent classification feeding deterministic retrieval. Sketch archived in [`docs/technology/chatbot-semantic-router.md`](docs/technology/chatbot-semantic-router.md); revisit if a chatbot or guided-navigation feature enters scope much later in the project.

**Open decisions**
- Whether to extend the signal→key pattern to Engineering Practices for consistency.
- Top-level "done" definition for the project as a whole.
- Sequencing guidance for Stories across the three Business Principles tiers.
