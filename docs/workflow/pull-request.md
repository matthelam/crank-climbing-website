# Stage 9: Pull Request

Detail page for the Workflow **Pull Request** row — Signal: "Clean locally; no PR open for this branch".

## Purpose

The PR is the handoff from local state to shared state. It is the first time the work becomes visible to reviewers, CI, and the deployment pipeline. The PR body is not a formality — it is the contract that declares what changed, why, what tests assert the change, and how the change maps back to Requirement and Story.

This is also the first stage where an agent can lose alignment with the Workflow silently. A PR that does not link to its Story is unauditable. A PR that does not name the AC it satisfies cannot be verified in Stage 10 — reviewers don't know what to check, and the Dual-AC Verification becomes an opinion rather than a check.

The Vercel Git integration also fires here: every PR gets an automatic **Preview deployment**, which becomes the running system against which Stage 10 verifies goal-level AC.

## Enter / Exit

- **Enter when:** Local verification is clean; no PR is open for this branch.
- **Exit when:** A PR is open, CI is green on the head commit, and the PR body links to the Story and Task and names the AC being satisfied.

## Rule

Every PR links to its Story (and by extension the Requirement). Every PR names the technical AC it satisfies and cites the tests that assert them. Every PR waits for CI green before handoff to [Stage 10](dual-ac-verification.md).

## Artifact produced

An open PR with:
- Link to the Story (and transitively Requirement, Elaboration, Scope).
- Named technical AC with cited test file(s).
- Automatic Vercel Preview deployment URL.
- Green CI on the head commit.

## PR body shape (suggested)

- **Story link:** `intent/stories/<id>.md` (or current equivalent)
- **Technical AC satisfied:** bulleted list, each mapped to the test file that asserts it.
- **Test evidence:** which tests turned green; which existed before vs. added in this PR.
- **Preview deployment:** link (Vercel auto-comments this).


## Agent protocol

1. Confirm local verification is clean (Stage 8 exit).
2. Push the branch.
3. Open the PR. Include: Story link, technical AC list, test evidence.
4. Wait for CI (GitHub Actions). If red, return to [Stage 7](recursive-build.md) or [Stage 8](local-verification.md) as the failure warrants.
5. When CI is green and the Vercel Preview deploys, advance to [Stage 10: Dual-AC Verification](dual-ac-verification.md).
