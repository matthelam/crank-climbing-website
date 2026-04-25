"""Human-in-the-loop gate node.

Honours each layer's gates.yaml hitl.policy:
  required - always pause for human approval
  optional - pause only if a configured trigger fires
  skip     - bypass entirely
"""

from __future__ import annotations

from ..layers import load_layer
from ..state import LayerState


def hitl_gate(state: LayerState) -> LayerState:
    layer = load_layer(state["layer_id"])
    policy = layer["gates"].get("hitl", {}).get("policy", "optional")

    if policy == "skip":
        return {**state, "hitl_decision": "skipped"}

    if policy == "required":
        decision = _prompt(state, reason="HITL policy is required for this layer.")
        return {**state, "hitl_decision": decision}

    # optional - check triggers
    triggered = _any_trigger_fires(state, layer)
    if triggered:
        decision = _prompt(state, reason=f"HITL trigger fired: {triggered}")
        return {**state, "hitl_decision": decision}

    return {**state, "hitl_decision": "skipped"}


def _any_trigger_fires(state: LayerState, layer: dict) -> str | None:
    triggers = layer["gates"].get("hitl", {}).get("triggers", [])
    for t in triggers:
        tid = t["id"]
        if tid == "supersede_of_locked_artifact" and state.get("supersedes"):
            return tid
        # exit_uncertainty_above_threshold and others extend here
    return None


def _prompt(state: LayerState, reason: str) -> str:
    """v1: blocking stdin prompt. Replaceable by interrupt-based HITL when wired
    to LangGraph's checkpointer + Command resume API."""
    print()
    print(f"[HITL] layer {state['layer_id']}")
    print(f"  reason: {reason}")
    print(f"  artifact: {state.get('artifact_path')}")
    print("  approve? [y/n] ", end="", flush=True)
    answer = input().strip().lower()
    return "approved" if answer == "y" else "rejected"
