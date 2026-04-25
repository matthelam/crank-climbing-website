---
name: layer-09-recursive-build
description: Implement leaf-most missing artifact until tests green (layer 09). Invoked by orchestration/graphs/layer_09_recursive_build.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 09 — Recursive Build

Make red tests green by implementing leaf-most missing artifacts first. The densest loop in the orchestration — TDD green + refactor, recursive.

**Contract:** [`layers/09-recursive-build/layer.md`](../../../layers/09-recursive-build/layer.md). **Schema:** [`layers/09-recursive-build/schema.output.json`](../../../layers/09-recursive-build/schema.output.json).

## Steps

1. Read Stories + Tasks from `07`, red-test-run from `08`, brand-kit tokens from `02`.
2. Identify the leaf-most missing artifact: the Task whose dependencies are all already implemented.
3. Implement it:
   - Component → scaffold to `src/{path}/{Component}.tsx`, wire Tailwind tokens, satisfy Storybook test.
   - Module → scaffold + satisfy unit test.
   - Page → wire route, satisfy e2e test.
4. Inner loop: red → implement → run targeted test.
   - If still red and `attempt < 5`: refine with failure as feedback. Loop.
   - If still red after 5 attempts: surface; this is a re-enter-step trigger.
5. When the targeted test goes green, run the full suite to confirm no regressions.
6. Mark Task complete in the build-run artifact. Move to next leaf.
7. When all Tasks for current Story are green, move to next Story.
8. Write `intent/build-runs/{slug}-{ISO-timestamp}.md` summarising completed Tasks and supersedes (if any).
9. Reply with the build-run path on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| Test passes but type-check fails | Treat type error as a red test; iterate. |
| Component requires a binding capability not in `bindings.yaml` | Stop; capability addition is a scaffold change (PR against the manifest), not an inline call. |
| Implementation depends on a Story not yet built | Re-order; that Story is the new leaf. |

## Lock-once

The build-run record is lock-once. Implementation files under `src/` are application code, not intent.
