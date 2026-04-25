"""Schema validation node.

Reads the produced artifact, parses its frontmatter or JSON-shaped body, and
validates against the layer's schema.output.json.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any

import yaml
from jsonschema import ValidationError, validate

from ..layers import load_layer
from ..state import LayerState


def validate_against_schema(state: LayerState) -> LayerState:
    layer = load_layer(state["layer_id"])
    schema = layer["output_schema"]
    artifact_path = state.get("artifact_path")
    if not artifact_path or not Path(artifact_path).exists():
        return {**state, "status": "failed", "error": "no artifact to validate"}

    try:
        payload = _extract_payload(Path(artifact_path))
        validate(instance=payload, schema=schema)
    except ValidationError as e:
        return {**state, "status": "failed", "error": f"schema validation failed: {e.message}"}
    except Exception as e:  # noqa: BLE001
        return {**state, "status": "failed", "error": f"validation node error: {e}"}

    return {**state, "output_payload": payload, "status": "running"}


def _extract_payload(path: Path) -> dict[str, Any]:
    """Best-effort payload extraction.

    Layer artifacts ship as markdown with a YAML frontmatter block carrying the
    structured fields. This pulls the frontmatter; if absent, returns an empty
    dict so the schema can still validate required-field absence.
    """
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---"):
        return {}
    end = text.find("---", 3)
    if end == -1:
        return {}
    fm = text[3:end].strip()
    return yaml.safe_load(fm) or {}
