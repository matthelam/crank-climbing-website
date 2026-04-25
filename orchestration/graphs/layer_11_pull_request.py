"""Subgraph for layer 11-pull-request.

Importable entrypoint:
    from orchestration.graphs.layer_11_pull_request import graph
    result = graph.invoke({"layer_id": "11-pull-request", ...})

Override the default subgraph by editing this file only when this layer needs
something the canonical template (_subgraph_template.build_subgraph) does not
express. The canonical case requires no edits here.
"""

from ._subgraph_template import build_subgraph

graph = build_subgraph("11-pull-request")
