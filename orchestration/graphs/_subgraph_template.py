"""Canonical layer subgraph shape.

Every layer subgraph follows this pattern:

    enforce_entry_gates  ->  invoke_skill  ->  validate_against_schema  ->
        hitl_gate  ->  enforce_exit_gates

Loop edges defined in gates.yaml are rendered as conditional re-entries:

  retry_within_step:  invoke_skill -> invoke_skill (max attempts from gates.yaml)
  re_enter_step:      hitl_gate(rejected) -> invoke_skill
  re_enter_phase:     handled by the ROOT graph, not the subgraph

Use `build_subgraph(layer_id)` to materialize the StateGraph for a layer.
"""

from __future__ import annotations

from langgraph.graph import END, START, StateGraph

from ..nodes import (
    enforce_entry_gates,
    enforce_exit_gates,
    hitl_gate,
    invoke_skill,
    validate_against_schema,
)
from ..state import LayerState
from ..layers import load_layer


def build_subgraph(layer_id: str):
    """Construct a StateGraph for a layer, honouring its gates.yaml loops."""
    g = StateGraph(LayerState)

    g.add_node("entry_gates", enforce_entry_gates)
    g.add_node("invoke", invoke_skill)
    g.add_node("validate", validate_against_schema)
    g.add_node("hitl", hitl_gate)
    g.add_node("exit_gates", enforce_exit_gates)

    g.add_edge(START, "entry_gates")

    # entry -> invoke unless gates failed
    g.add_conditional_edges(
        "entry_gates",
        lambda s: "invoke" if s.get("status") == "running" else END,
    )

    # invoke -> validate
    g.add_edge("invoke", "validate")

    # validate -> retry invoke (up to N) or proceed to hitl
    layer = load_layer(layer_id)
    max_attempts = (
        layer["gates"]
        .get("loop_edges", {})
        .get("retry_within_step", {})
        .get("max_attempts", 3)
    )

    def _validate_router(s: LayerState) -> str:
        if s.get("status") == "failed" and s.get("attempts", 0) < max_attempts:
            return "invoke"
        if s.get("status") == "failed":
            return END
        return "hitl"

    g.add_conditional_edges("validate", _validate_router)

    # hitl -> re_enter_step on rejection, else exit_gates
    def _hitl_router(s: LayerState) -> str:
        if s.get("hitl_decision") == "rejected":
            return "invoke"
        return "exit_gates"

    g.add_conditional_edges("hitl", _hitl_router)

    g.add_edge("exit_gates", END)

    return g.compile()
