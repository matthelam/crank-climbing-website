"""Layer registry — discovers layer metadata from layers/*/."""

from __future__ import annotations

import functools
import json
from pathlib import Path
from typing import Any

import yaml

REPO_ROOT = Path(__file__).resolve().parent.parent
LAYERS_DIR = REPO_ROOT / "layers"

LAYER_ORDER = [
    "00-bootstrap",
    "01-business-decomposition",
    "02-brand-kit",
    "03-ux",
    "04-scope",
    "05-elaboration",
    "06-requirements",
    "07-stories-tasks",
    "08-red-tests",
    "09-recursive-build",
    "10-local-verification",
    "11-pull-request",
    "12-dual-ac-verification",
    "13-review",
    "14-merge-deploy-observe",
]
"""Linear happy-path order. Maintenance layer (M-maintenance) runs out of band."""


@functools.lru_cache(maxsize=64)
def load_layer(layer_id: str) -> dict[str, Any]:
    """Load a layer's gates.yaml, schemas, and a pointer to its layer.md."""
    layer_dir = LAYERS_DIR / layer_id
    if not layer_dir.is_dir():
        raise FileNotFoundError(f"unknown layer: {layer_id}")

    with open(layer_dir / "gates.yaml", encoding="utf-8") as f:
        gates = yaml.safe_load(f)
    with open(layer_dir / "schema.input.json", encoding="utf-8") as f:
        input_schema = json.load(f)
    with open(layer_dir / "schema.output.json", encoding="utf-8") as f:
        output_schema = json.load(f)

    return {
        "id": layer_id,
        "dir": layer_dir,
        "layer_md": layer_dir / "layer.md",
        "gates": gates,
        "input_schema": input_schema,
        "output_schema": output_schema,
    }


def successor(layer_id: str) -> str | None:
    if layer_id not in LAYER_ORDER:
        return None
    idx = LAYER_ORDER.index(layer_id)
    if idx + 1 >= len(LAYER_ORDER):
        return None
    return LAYER_ORDER[idx + 1]


def predecessor(layer_id: str) -> str | None:
    if layer_id not in LAYER_ORDER:
        return None
    idx = LAYER_ORDER.index(layer_id)
    if idx == 0:
        return None
    return LAYER_ORDER[idx - 1]
