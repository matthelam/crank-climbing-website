"""Shared state types for layer subgraphs.

Every layer subgraph operates on a LayerState. The root graph composes them by
wiring outputs of one layer's state into the inputs of the next.
"""

from __future__ import annotations

from typing import Any, Literal, TypedDict


HitlPolicy = Literal["optional", "required", "skip"]
LayerStatus = Literal["pending", "running", "ok", "failed", "superseded"]


class UpstreamRef(TypedDict):
    layer: str
    artifact_path: str


class LayerState(TypedDict, total=False):
    """Shape passed into and out of every layer subgraph."""

    layer_id: str
    upstream_refs: list[UpstreamRef]
    overrides: dict[str, Any]

    # Outputs
    artifact_path: str | None
    artifact_id: str | None
    supersedes: str | None
    output_payload: dict[str, Any] | None

    # Bookkeeping
    status: LayerStatus
    attempts: int
    hitl_decision: Literal["approved", "rejected", "skipped"] | None
    error: str | None
