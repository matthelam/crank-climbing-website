---
name: layer-10-local-verification
description: Type-check, lint, build, and full test suite clean (layer 10). Invoked by orchestration/graphs/layer_10_local_verification.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
shell: powershell
disable-model-invocation: true
---

# Layer 10 — Local Verification

Run deterministic local checks. Cheap to run, cheap to fail-fast. HITL skipped.

**Contract:** [`layers/10-local-verification/layer.md`](../../../layers/10-local-verification/layer.md). **Schema:** [`layers/10-local-verification/schema.output.json`](../../../layers/10-local-verification/schema.output.json).

## Steps

1. Run, in order, capturing each outcome:
   - `npx --yes tsc --noEmit` (capability `type_check`).
   - `npx --yes vitest run` (capability `unit_test`).
   - `npx --yes playwright test` (capability `e2e_test`).
   - `npm run build` (capability `app_routing` — Next.js production build).
2. Write `intent/verifications/{slug}-{ISO-timestamp}.md` with command, exit code, summary line per check.
3. If any check fails, the artifact is still written; orchestrator routes via `re_enter_phase` to layer 09.
4. Reply with the verification path on the final line.

## Failure modes

| Failure | Recovery |
|---|---|
| Build fails on a route not touched by current Story | Verify regression is in scope; if not, supersede the Story or escalate. |
| E2E flakes (passes on rerun) | Mark as flake in report; do not gate on a single failed run. File a Task to stabilise. |

## Lock-once

The verification report is lock-once.
