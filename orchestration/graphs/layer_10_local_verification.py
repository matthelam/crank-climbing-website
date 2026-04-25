"""Subgraph for layer 10-local-verification.

Importable entrypoint:
    from orchestration.graphs.layer_10_local_verification import graph
    result = graph.invoke({"layer_id": "10-local-verification", ...})

Override the default subgraph by editing this file only when this layer needs
something the canonical template (_subgraph_template.build_subgraph) does not
express. The canonical case requires no edits here.
"""

from ._subgraph_template import build_subgraph

graph = build_subgraph("10-local-verification")
