"""Root recursion graph.

Composes the layer subgraphs in linear order (LAYER_ORDER) with these loop edges:

  re_enter_phase: any layer can request a jump back to a predecessor layer.
                  We model this as a conditional edge from each subgraph's exit
                  to the layer named in state.error or state.next_layer override.

The root graph is the only place that knows about layer ordering. Each layer
subgraph is opaque to it.
"""

from __future__ import annotations

from typing import Any, TypedDict

from langgraph.graph import END, START, StateGraph

from ..layers import LAYER_ORDER
from ._subgraph_template import build_subgraph


class RootState(TypedDict, total=False):
    target_url: str
    manual_brief: str
    start_layer: str
    stop_after: str
    layer_states: dict[str, dict[str, Any]]
    last_layer: str
    last_status: str
    last_error: str | None


def build_root_graph():
    g = StateGraph(RootState)

    # Materialize each layer subgraph as a node. Subgraphs convert RootState ->
    # LayerState on entry and merge results back on exit.
    for layer_id in LAYER_ORDER:
        sub = build_subgraph(layer_id)
        g.add_node(layer_id, _wrap_subgraph(layer_id, sub))

    g.add_edge(START, LAYER_ORDER[0])

    for i, layer_id in enumerate(LAYER_ORDER):
        is_last = i == len(LAYER_ORDER) - 1
        nxt = None if is_last else LAYER_ORDER[i + 1]

        def _router(s: RootState, here=layer_id, after=nxt) -> str:
            ls = s.get("layer_states", {}).get(here, {})
            status = ls.get("status")
            if status == "failed":
                return END  # surface the failure to the operator; no auto re-enter for v1
            if s.get("stop_after") == here:
                return END
            return after if after else END

        g.add_conditional_edges(layer_id, _router)

    return g.compile()


def _wrap_subgraph(layer_id: str, sub):
    """Adapter that runs a layer subgraph from RootState and merges results."""

    def _run(s: RootState) -> RootState:
        layer_input = {
            "layer_id": layer_id,
            "upstream_refs": _resolve_upstream_refs(layer_id, s),
            "overrides": _overrides_for(layer_id, s),
            "status": "pending",
            "attempts": 0,
        }
        out = sub.invoke(layer_input)
        ls = dict(s.get("layer_states", {}))
        ls[layer_id] = out
        return {
            **s,
            "layer_states": ls,
            "last_layer": layer_id,
            "last_status": out.get("status"),
            "last_error": out.get("error"),
        }

    return _run


def _resolve_upstream_refs(layer_id: str, s: RootState) -> list[dict[str, str]]:
    if layer_id == "00-bootstrap":
        return []
    idx = LAYER_ORDER.index(layer_id)
    prev_id = LAYER_ORDER[idx - 1]
    prev = s.get("layer_states", {}).get(prev_id, {})
    artifact = prev.get("artifact_path")
    if not artifact:
        return []
    return [{"layer": prev_id, "artifact_path": artifact}]


def _overrides_for(layer_id: str, s: RootState) -> dict[str, Any]:
    if layer_id == "01-business-decomposition":
        return {
            "target_url": s.get("target_url"),
            "manual_brief": s.get("manual_brief"),
        }
    return {}
