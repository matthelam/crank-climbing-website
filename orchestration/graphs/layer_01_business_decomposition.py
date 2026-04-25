"""Subgraph for layer 01-business-decomposition.

Importable entrypoint:
    from orchestration.graphs.layer_01_business_decomposition import graph
    result = graph.invoke({"layer_id": "01-business-decomposition", ...})

Override the default subgraph by editing this file only when this layer needs
something the canonical template (_subgraph_template.build_subgraph) does not
express. The canonical case requires no edits here.
"""

from ._subgraph_template import build_subgraph

graph = build_subgraph("01-business-decomposition")
