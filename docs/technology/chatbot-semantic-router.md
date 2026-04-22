# Chatbot — Semantic Router Architecture

> **Status: parked.** Not a current Crank feature. Captured now so the architectural thinking is not re-derived when a chatbot or guided-navigation capability enters scope much later in the project.

Back-tiered reference for the future. Linked from the [Parked concepts section of the README](../../README.md#todo).

## Constraint

If Crank ever introduces a chatbot that directs users to site content, the primary constraint is **consistency** — the same question must always yield the same answer. This rules out letting an LLM generate freely against raw site content.

## Architecture — LLM at the front, deterministic retrieval downstream

The LLM is placed early in the pipeline, doing a narrow gatable task. Everything downstream is deterministic.

| Layer | Role | Determinism |
|-------|------|-------------|
| 1. LLM intent interpretation | Parse utterance into a canonical intent (e.g. `MEMBERSHIP_CANCELLATION`). Classification, not generation. | Gated: few-shot examples, schema validation, confidence threshold. Escalate to human or clarifying question on low confidence. |
| 2. Semantic vector lookup | Intent is a key; value is a weighted list of candidate answers (e.g. 60% FAQ X, 30% article Y, 10% contact form Z). | Fully deterministic — a table lookup. |
| 3. Retrieval and ranking | Pull top-N candidates by weight. Return. | Fully deterministic — zero LLM. |
| 4. Constrained synthesis *(optional)* | If a single natural-language response is required, one LLM pass synthesises retrieved candidates. "Use only content provided." Low temperature, citation-gated, faithfulness-checked. | Phrasing may vary; information content may not. |

## Why this is productionisable

- **Auditable.** "Why did we send them to article X?" is always answerable: their intent classified as `X_INTENT`, which is weighted toward article X.
- **Variance is placed.** Intent classification has a discrete output space; confidence is measurable. Retrieval and ranking are mechanical.
- **Phrasing variance is tolerable; information variance is not.** The information returned is always the same.

## Ingest pipeline — populating the intent-to-content map

The semantic database is built by a separate AI-driven ingest pipeline:

1. **Extract atomic chunks.** Break each page/document into self-contained semantic units.
2. **Classify chunks against intents.** LLM reads each chunk and maps it to applicable intents. Produces a many-to-many mapping.
3. **Weight the mappings.** Manually, via LLM scoring, or via engagement metrics.
4. **Populate the database.** Intent → weighted chunk ID list.
5. **Governance loop.** Unanticipated queries are flagged. Mappings are refined intentionally, not drifted.

LLM role here is **classification and curation**, not generation. Output is schema-constrained and human-reviewable before it goes live.

## Tuning interface

Over time, humans (content owners, support teams) need to adjust the intent-to-content mappings without touching code. Modern evolution of the Google Search Appliance keyword-tuning workflow: "for this intent, these are the current candidates and their weights — is this right?" Versioned, auditable, reweightable.

## Leverage existing infrastructure

This architecture maps cleanly onto existing enterprise search products — **Azure AI Search**, Bing, Algolia — which already provide:

- Ingest pipelines with chunking and vectorisation
- Hybrid keyword + semantic retrieval
- Semantic re-ranking using deep learning models
- Relevance tuning surfaces (the tuning interface, pre-built)
- A/B testing, personalisation, ranking adjustments

The AI layer narrows to what it is uniquely good at — intent classification and chunk-to-intent mapping during ingest. Retrieval and ranking are delegated to battle-tested infrastructure. Consistent with the README's constraint: future capabilities are drawn from the Vercel, GitHub, or Microsoft ecosystems.

## Industry-standard pattern

Known in the literature as **query understanding before retrieval** (OpenSource Connections, Yelp Engineering, Weaviate, Neo4j) or, in Microsoft's framing, **semantic routing** (Azure AI Search reference architecture). Not novel — an assembled standard pattern.

## Applicability to Crank

Currently: none. Crank's scope is a consumer-facing marketing and booking site, not a support chatbot. This document exists so the architectural thinking is ready when the feature is eventually scoped — likely well after the core site ships.
