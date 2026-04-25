# layers/

The stable abstract phases of an AI-first website rebuild. **Layers do not change when you clone the scaffold.** Tool bindings change (in [`bindings.yaml`](../bindings.yaml)); the layers themselves are framework-owned.

Each layer is a directory holding four files in the canonical shape defined by [`_template/`](_template/):

```
layers/XX-{slug}/
  layer.md             # prose contract: purpose, position, IO, gates, HITL, loop edges
  schema.input.json    # JSON Schema for inputs
  schema.output.json   # JSON Schema for outputs (lock-once artifacts)
  gates.yaml           # entry/exit conditions, HITL policy, loop edges
```

A LangGraph subgraph under [`orchestration/graphs/XX-{slug}.py`](../orchestration/graphs/) executes each layer. The skill body that the subgraph invokes lives at [`.claude/skills/layer-XX-{slug}/SKILL.md`](../.claude/skills/).

## Layer index

| # | Layer | Purpose | HITL default |
|---|-------|---------|--------------|
| 00 | [Bootstrap](00-bootstrap/) | Provision tools, infra, accounts on a fresh clone | required |
| 01 | [Business Decomposition](01-business-decomposition/) | Extract business functions from existing site + brief | optional |
| 02 | [Brand Kit](02-brand-kit/) | Synthesize palette, typography, motion, copy voice | optional |
| 03 | [UX](03-ux/) | Generate UX stories and screen-level designs | optional |
| 04 | [Scope](04-scope/) | Lock the scope document for this rebuild | optional |
| 05 | [Elaboration](05-elaboration/) | Surface risks, integrations, architectural calls | optional |
| 06 | [Requirements](06-requirements/) | Author requirements with goal-level acceptance criteria | optional |
| 07 | [Stories + Tasks](07-stories-tasks/) | Decompose into component-shaped stories and tasks | optional |
| 08 | [Red Tests](08-red-tests/) | Author failing tests before implementation | optional |
| 09 | [Recursive Build](09-recursive-build/) | Implement leaf-most missing artifact until tests green | optional |
| 10 | [Local Verification](10-local-verification/) | Type-check / lint / build clean | skip |
| 11 | [Pull Request](11-pull-request/) | Open the PR | optional |
| 12 | [Dual-AC Verification](12-dual-ac-verification/) | Verify story + feature AC, record notes | required |
| 13 | [Review](13-review/) | Code review and approval | required |
| 14 | [Merge + Deploy + Observe](14-merge-deploy-observe/) | Merge, deploy, resume observability | required |
| M | [Maintenance](M-maintenance/) | Detect drift; propose superseding bindings / IaC | optional |

## Numbering and ordering

Layers 00 through 14 are linear in the happy path. The maintenance layer (`M`) runs on a schedule, not as part of the main flow. Loop edges (`retry_within_step`, `re_enter_step`, `re_enter_phase`) are declared per layer in `gates.yaml` and wired by the LangGraph subgraph; the orchestration root graph composes them.

## Lock-once

Outputs of every layer are lock-once artifacts under [`intent/`](../intent/). Revisions produce new files with `supersedes` set to the prior `artifact_id` — they do not edit existing files.
