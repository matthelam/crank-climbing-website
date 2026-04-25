"""Loader and accessor for bindings.yaml.

This is the only module that knows the on-disk shape of the manifest. Everything
else asks the registry for a capability by id.
"""

from __future__ import annotations

import functools
from pathlib import Path
from typing import Any

import yaml
from jsonschema import validate

REPO_ROOT = Path(__file__).resolve().parent.parent
BINDINGS_PATH = REPO_ROOT / "bindings.yaml"
BINDINGS_SCHEMA_PATH = REPO_ROOT / "bindings.schema.json"


@functools.lru_cache(maxsize=1)
def load_bindings() -> dict[str, Any]:
    """Load and validate bindings.yaml. Cached for the process lifetime."""
    import json

    with open(BINDINGS_PATH, encoding="utf-8") as f:
        data = yaml.safe_load(f)
    with open(BINDINGS_SCHEMA_PATH, encoding="utf-8") as f:
        schema = json.load(f)
    validate(instance=data, schema=schema)
    return data


def get_capability(capability_id: str) -> dict[str, Any]:
    """Return one capability definition or raise KeyError."""
    data = load_bindings()
    caps = data["capabilities"]
    if capability_id not in caps:
        raise KeyError(f"unknown capability: {capability_id}")
    return caps[capability_id]


def list_capabilities(category: str | None = None) -> dict[str, dict[str, Any]]:
    """Return all capabilities, optionally filtered by category."""
    data = load_bindings()
    caps = data["capabilities"]
    if category is None:
        return caps
    return {k: v for k, v in caps.items() if v.get("category") == category}


def tool_for(capability_id: str, audience: str = "ai") -> dict[str, str]:
    """Resolve the {tool, version, docs_url} binding for a capability + audience."""
    cap = get_capability(capability_id)
    binding = cap.get(f"{audience}_binding") or cap["ai_binding"]
    return binding
