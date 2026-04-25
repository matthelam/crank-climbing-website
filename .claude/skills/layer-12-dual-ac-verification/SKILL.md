---
name: layer-12-dual-ac-verification
description: Verify story + feature AC, record evidence (layer 12). Invoked by orchestration/graphs/layer_12_dual_ac_verification.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 12 — Dual-AC Verification

Verify both Story-level technical AC and Feature-level goal AC against the running PR. Required HITL gate.

**Contract:** [`layers/12-dual-ac-verification/layer.md`](../../../layers/12-dual-ac-verification/layer.md). **Schema:** [`layers/12-dual-ac-verification/schema.output.json`](../../../layers/12-dual-ac-verification/schema.output.json).

## Steps

1. Read PR record from `11`. Read every Story and Feature artifact referenced.
2. For each **Story-AC** (technical, component scope): re-run named Vitest / Storybook test; capture pass/fail with command + summary.
3. For each **Feature-AC** (goal, user-flow scope): run named Playwright spec; capture screenshots via `mcp_chrome_devtools` or `mcp_playwright` if helpful.
4. If any AC fails: produces a supersede chain — affected Story or Feature is superseded with new requirement; orchestrator re-enters appropriate layer.
5. Write `intent/verifications-dual-ac/{pr-number}-{ISO-timestamp}.md` listing every AC with pass/fail + evidence references.
6. Post the same content as a PR comment via `gh pr comment`.
7. Reply with the verification-dual-ac path on the final line.

## HITL

`required` — human reviews the dual-AC report before approving the PR. HITL gate runs after artifact is written.

## Failure modes

| Failure | Recovery |
|---|---|
| Story-AC passes but Feature-AC fails | Supersede the Feature; usually Story decomposition was incomplete. |
| Evidence capture (screenshot) fails | Note the failure; verbal evidence is acceptable for borderline cases. |

## Lock-once

The dual-AC verification record is lock-once.
