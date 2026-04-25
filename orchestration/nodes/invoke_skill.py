"""Bridge node: invokes a Claude Code skill via the Claude Agent SDK.

Pairs a layer with its skill (`.claude/skills/layer-{id}/SKILL.md`). The skill
performs the actual work; LangGraph supplies the inputs and consumes the outputs.
"""

from __future__ import annotations

import asyncio
import json
import os
from pathlib import Path
from typing import Any

from ..state import LayerState

REPO_ROOT = Path(__file__).resolve().parent.parent.parent


def invoke_skill(state: LayerState) -> LayerState:
    """Resolve the skill for this layer and run it via Claude Agent SDK.

    The SDK call is wrapped in asyncio.run because LangGraph nodes are sync.
    The skill consumes `upstream_refs` + `overrides` from state and writes its
    artifact to `intent/<type>/<slug>-<timestamp>.md`. The new path is returned
    in the state.
    """
    layer_id = state["layer_id"]
    skill_name = f"layer-{layer_id}"

    prompt = _build_prompt(state)

    try:
        artifact_path = asyncio.run(_run_skill(skill_name, prompt))
    except Exception as e:  # noqa: BLE001 — surface any SDK error into state
        return {**state, "status": "failed", "error": f"skill {skill_name} failed: {e}"}

    return {
        **state,
        "artifact_path": str(artifact_path),
        "artifact_id": Path(artifact_path).stem,
        "status": "running",
        "attempts": state.get("attempts", 0) + 1,
    }


def _build_prompt(state: LayerState) -> str:
    refs = json.dumps(state.get("upstream_refs", []), indent=2)
    overrides = json.dumps(state.get("overrides", {}), indent=2)
    return (
        f"Invoke skill /layer-{state['layer_id']} with:\n\n"
        f"upstream_refs:\n{refs}\n\n"
        f"overrides:\n{overrides}\n\n"
        f"Write the resulting lock-once artifact under intent/, then reply with "
        f"only the artifact's repo-relative path."
    )


async def _run_skill(skill_name: str, prompt: str) -> Path:
    """Call Claude Agent SDK. Returns the artifact path the skill reports.

    NOTE: this implementation depends on the v0.5+ Claude Agent SDK Python API.
    If the import fails (e.g., the SDK isn't installed yet), we surface a clear
    message rather than masking it.
    """
    try:
        from claude_agent_sdk import ClaudeAgentOptions, query  # type: ignore
    except ImportError as e:
        raise RuntimeError(
            "claude_agent_sdk not installed. Run scripts/bootstrap.ps1 or "
            "`pip install claude-agent-sdk==0.5.0` first."
        ) from e

    options = ClaudeAgentOptions(
        cwd=str(REPO_ROOT),
        permission_mode="acceptEdits",
        allowed_tools=["Read", "Write", "Edit", "Glob", "Grep", "Bash", f"Skill({skill_name})"],
    )

    final_text = ""
    async for msg in query(prompt=prompt, options=options):
        # The Agent SDK streams typed messages; we collect the final text.
        text = getattr(msg, "text", None) or getattr(msg, "content", "")
        if isinstance(text, str):
            final_text = text

    candidate = final_text.strip().splitlines()[-1] if final_text.strip() else ""
    if not candidate:
        raise RuntimeError(f"skill {skill_name} returned no artifact path")

    return Path(candidate)
