---
name: layer-07-stories-tasks
description: Decompose Features into component-shaped Stories and Tasks (layer 07). Invoked by orchestration/graphs/layer_07_stories_tasks.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 07 — Stories + Tasks

Decompose Features into component-shaped Stories (Storybook-testable) and the Tasks that implement them.

**Contract:** [`layers/07-stories-tasks/layer.md`](../../../layers/07-stories-tasks/layer.md). **Schema:** [`layers/07-stories-tasks/schema.output.json`](../../../layers/07-stories-tasks/schema.output.json).

## Steps

1. Read Feature artifacts from `06`. Read UX screens from `03` and brand-kit tokens from `02`.
2. For each Feature:
   - Decompose into Stories — each Story = one component (Storybook-testable). Stories may declare dependencies on other Stories. Dependency graph must be acyclic.
   - For each Story, draft Tasks: e.g., "scaffold component", "wire Tailwind tokens", "write happy-path test", "write empty-state test", "write a11y test".
3. Validate against [`intent/schemas/story.schema.json`](../../../intent/schemas/story.schema.json) and [`intent/schemas/task.schema.json`](../../../intent/schemas/task.schema.json) when present.
4. Write one file per Story: `intent/stories/{story_id}-{ISO-timestamp}.md`.
5. Write one file per Task: `intent/tasks/{task_id}-{ISO-timestamp}.md`.
6. Reply with a JSON array of all new artifact paths on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| Dependency cycle detected | Re-decompose; one cycle-breaking refactor Task per cycle. |
| Story spans multiple components | Split into smaller Stories. |

## Lock-once

Stories and Tasks are new files. Revisions produce new files with `supersedes` set.
