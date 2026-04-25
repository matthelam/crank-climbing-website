"""Supersede helper — never edits an existing artifact; writes a new one.

Lock-once discipline: revisions are new files, with `supersedes` set to the prior
artifact_id. The prior file stays put for history and audit.
"""

from __future__ import annotations

from datetime import datetime, timezone
from pathlib import Path

from ..state import LayerState

REPO_ROOT = Path(__file__).resolve().parent.parent.parent


def write_artifact_supersede(state: LayerState) -> LayerState:
    """No-op pass-through. The actual supersede write is the skill's job — this
    node simply records the intent in state and ensures the prior artifact_id is
    captured. Kept as a separate node so subgraphs can route around it cleanly."""
    prior = state.get("artifact_id")
    return {**state, "supersedes": prior}


def next_artifact_path(layer_id: str, slug: str, intent_subdir: str) -> Path:
    """Helper for skills: where the next lock-once artifact should be written."""
    ts = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H%M%SZ")
    out_dir = REPO_ROOT / "intent" / intent_subdir
    out_dir.mkdir(parents=True, exist_ok=True)
    return out_dir / f"{slug}-{ts}.md"
