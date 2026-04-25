"""Entry/exit gate enforcement nodes.

Each gate is a callable returning (passed: bool, reason: str). Layers wire only
the gate ids declared in their gates.yaml; this module owns the implementations.
"""

from __future__ import annotations

from pathlib import Path
from typing import Any

from ..layers import load_layer
from ..state import LayerState


def enforce_entry_gates(state: LayerState) -> LayerState:
    layer = load_layer(state["layer_id"])
    for gate in layer["gates"].get("entry", []):
        ok, reason = _check(gate["id"], state)
        if not ok:
            return {**state, "status": "failed", "error": f"entry gate '{gate['id']}' failed: {reason}"}
    return {**state, "status": "running"}


def enforce_exit_gates(state: LayerState) -> LayerState:
    layer = load_layer(state["layer_id"])
    for gate in layer["gates"].get("exit", []):
        ok, reason = _check(gate["id"], state)
        if not ok:
            return {**state, "status": "failed", "error": f"exit gate '{gate['id']}' failed: {reason}"}
    return {**state, "status": "ok"}


def _check(gate_id: str, state: LayerState) -> tuple[bool, str]:
    """Resolve a gate id to a check. Extend by mapping gate ids to functions."""
    if gate_id == "predecessor_artifact_exists":
        for ref in state.get("upstream_refs", []):
            if not Path(ref["artifact_path"]).exists():
                return False, f"missing upstream artifact: {ref['artifact_path']}"
        return True, "ok"

    if gate_id == "input_validates":
        # Schema validation handled by validate_against_schema node; treat as advisory here.
        return True, "deferred to validate node"

    if gate_id == "output_artifact_committed":
        path = state.get("artifact_path")
        return (bool(path) and Path(path).exists()), f"artifact_path={path}"

    if gate_id == "output_validates":
        return True, "deferred to validate node"

    if gate_id == "hitl_gate_passed":
        decision = state.get("hitl_decision")
        return (decision in ("approved", "skipped")), f"hitl_decision={decision}"

    # Unknown gates are advisory until implemented.
    return True, f"gate '{gate_id}' not yet implemented; passing"
