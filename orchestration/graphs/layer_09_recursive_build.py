"""Subgraph for layer 09-recursive-build.

Importable entrypoint:
    from orchestration.graphs.layer_09_recursive_build import graph
    result = graph.invoke({"layer_id": "09-recursive-build", ...})

Override the default subgraph by editing this file only when this layer needs
something the canonical template (_subgraph_template.build_subgraph) does not
express. The canonical case requires no edits here.
"""

from ._subgraph_template import build_subgraph

graph = build_subgraph("09-recursive-build")
