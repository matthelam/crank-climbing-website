"""Subgraph for layer 07-stories-tasks.

Importable entrypoint:
    from orchestration.graphs.layer_07_stories_tasks import graph
    result = graph.invoke({"layer_id": "07-stories-tasks", ...})

Override the default subgraph by editing this file only when this layer needs
something the canonical template (_subgraph_template.build_subgraph) does not
express. The canonical case requires no edits here.
"""

from ._subgraph_template import build_subgraph

graph = build_subgraph("07-stories-tasks")
