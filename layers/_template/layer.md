# Layer XX — {Layer Name}

**Status:** *[TBD]* — copied from `_template`.

**Purpose.** One sentence stating what this layer accomplishes in the website-rebuild flow.

**Position.** Layer XX of the rebuild flow. Predecessor: `XX-{prev}`. Successor: `XX-{next}`.

## Inputs

The layer's pre-conditions, expressed as named artifacts produced by upstream layers.

- `intent/{type}/{slug}-{timestamp}.md` from layer `XX-{prev}`

Schema: [`schema.input.json`](schema.input.json).

## Outputs

Lock-once artifacts produced on successful exit. Each is committed and never edited; supersedes are produced as new artifacts with the prior id recorded.

- `intent/{type}/{slug}-{timestamp}.md`

Schema: [`schema.output.json`](schema.output.json).

## Bindings used

Capabilities this layer consumes from [`bindings.yaml`](../../bindings.yaml). Listed by capability id, not tool name — the tool resolution is the manifest's job.

- `capability_id_one`
- `capability_id_two`

## Gates

Entry and exit conditions. Authoritative form is [`gates.yaml`](gates.yaml).

- **Entry:** predecessor artifact exists and validates against its schema.
- **Exit:** output artifact exists and validates; HITL gate (if mandatory) approved.

## HITL policy

`optional` | `required` | `skip`. Default: `optional`.

When `optional`, the orchestrator runs the HITL gate node only if the configured trigger fires (e.g., output uncertainty above threshold, supersede of a previously-locked artifact).

## Loop edges

Explicit re-entry edges modelled in the LangGraph subgraph. Each edge has a trigger condition and a max-attempts cap.

- `retry_within_step`: validation_fails → re-run the same node, max 3 attempts.
- `re_enter_step`: hitl_supersede → re-run the layer with the superseding input.
- `re_enter_phase`: upstream_artifact_superseded → re-enter from the layer that owns the changed upstream.

## Skill

[`/layer-XX-{slug}`](../../.claude/skills/layer-XX-{slug}/SKILL.md) — the Claude Code skill that performs this layer's work. Frontmatter (`allowed-tools`, `shell`, `disable-model-invocation`) is generated from `bindings.yaml` by `scripts/generate-skills.ps1`; the body is hand-authored.

## Subgraph

[`orchestration/graphs/XX-{slug}.py`](../../orchestration/graphs/XX-{slug}.py) — LangGraph subgraph that wires inputs, the skill invocation, gates, and loop edges.
