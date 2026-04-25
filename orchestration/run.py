"""CLI entrypoint for the orchestrator.

Usage:
    python -m orchestration.run --layer 01-business-decomposition --url https://example.com
    python -m orchestration.run --from 00-bootstrap --to 14-merge-deploy-observe
    python -m orchestration.run --list

Single-layer mode runs that layer's subgraph in isolation.
Range mode runs the root graph from --from up to (and including) --to.
"""

from __future__ import annotations

import json
import sys

import click
from rich.console import Console
from rich.table import Table

from .bindings import list_capabilities, load_bindings
from .graphs._root import build_root_graph
from .graphs._subgraph_template import build_subgraph
from .layers import LAYER_ORDER, load_layer

console = Console()


@click.group()
def cli() -> None:
    """Crank scaffold orchestrator."""


@cli.command("list")
def list_layers() -> None:
    """List layers in linear order with HITL policy and successor."""
    table = Table(title="Layers (linear order)")
    table.add_column("#")
    table.add_column("Layer id")
    table.add_column("HITL")
    table.add_column("Successor")
    for i, lid in enumerate(LAYER_ORDER):
        layer = load_layer(lid)
        nxt = LAYER_ORDER[i + 1] if i + 1 < len(LAYER_ORDER) else "—"
        table.add_row(
            str(i),
            lid,
            layer["gates"].get("hitl", {}).get("policy", "?"),
            nxt,
        )
    console.print(table)


@cli.command("bindings")
@click.option("--category", default=None)
def show_bindings(category: str | None) -> None:
    """Print the resolved bindings table."""
    caps = list_capabilities(category)
    table = Table(title=f"Bindings ({category or 'all'})")
    table.add_column("Capability")
    table.add_column("Description")
    table.add_column("AI tool")
    table.add_column("Version")
    for cid, cap in caps.items():
        b = cap["ai_binding"]
        table.add_row(cid, cap["description"], b["tool"], b["version"])
    console.print(table)


@cli.command("layer")
@click.option("--id", "layer_id", required=True, help="Layer id, e.g. 01-business-decomposition.")
@click.option("--url", default=None, help="target_url override (for layer 01).")
@click.option("--brief", default=None, help="manual_brief override (for layer 01).")
@click.option("--upstream", default=None, help="JSON list of upstream_refs.")
def run_layer(layer_id: str, url: str | None, brief: str | None, upstream: str | None) -> None:
    """Run a single layer subgraph."""
    sub = build_subgraph(layer_id)
    upstream_refs = json.loads(upstream) if upstream else []
    overrides: dict = {}
    if url:
        overrides["target_url"] = url
    if brief:
        overrides["manual_brief"] = brief
    state = {
        "layer_id": layer_id,
        "upstream_refs": upstream_refs,
        "overrides": overrides,
        "status": "pending",
        "attempts": 0,
    }
    result = sub.invoke(state)
    console.print_json(json.dumps(result, default=str))


@cli.command("run")
@click.option("--from", "from_layer", default="00-bootstrap")
@click.option("--to", "to_layer", default=None)
@click.option("--url", default=None)
@click.option("--brief", default=None)
def run_root(from_layer: str, to_layer: str | None, url: str | None, brief: str | None) -> None:
    """Run the root graph across a layer range."""
    if from_layer != "00-bootstrap":
        console.print(
            f"[yellow]NOTE:[/] root currently always starts at 00-bootstrap; "
            f"--from {from_layer} is honoured by skipping to that layer once supported."
        )
    graph = build_root_graph()
    initial = {
        "target_url": url,
        "manual_brief": brief,
        "stop_after": to_layer,
        "layer_states": {},
    }
    result = graph.invoke(initial)
    console.print_json(json.dumps(result, default=str))


def main() -> None:
    cli()


if __name__ == "__main__":
    main()
