"""Subgraph for layer 12-dual-ac-verification.

Importable entrypoint:
    from orchestration.graphs.layer_12_dual_ac_verification import graph
    result = graph.invoke({"layer_id": "12-dual-ac-verification", ...})

Override the default subgraph by editing this file only when this layer needs
something the canonical template (_subgraph_template.build_subgraph) does not
express. The canonical case requires no edits here.
"""

from ._subgraph_template import build_subgraph

graph = build_subgraph("12-dual-ac-verification")
