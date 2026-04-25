"""Subgraph for layer 02-brand-kit.

Importable entrypoint:
    from orchestration.graphs.layer_02_brand_kit import graph
    result = graph.invoke({"layer_id": "02-brand-kit", ...})

Override the default subgraph by editing this file only when this layer needs
something the canonical template (_subgraph_template.build_subgraph) does not
express. The canonical case requires no edits here.
"""

from ._subgraph_template import build_subgraph

graph = build_subgraph("02-brand-kit")
