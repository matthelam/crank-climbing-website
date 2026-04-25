---
name: layer-01-business-decomposition
description: Extract business functions from the existing site + brief (layer 01). Invoked by orchestration/graphs/layer_01_business_decomposition.py via Claude Agent SDK; not autonomously model-invoked.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
shell: powershell
disable-model-invocation: true
---

# Layer 01 — Business Decomposition

Decompile a target business by analysing its existing website, optionally augmented by a human-supplied brief. Produce a structured map of business functions across the three Business Principles tiers (Conversion, Consideration, Retention), the brand voice, and any captured asset references.

**Authoritative contract:** [`layers/01-business-decomposition/layer.md`](../../../layers/01-business-decomposition/layer.md). **Output schema:** [`layers/01-business-decomposition/schema.output.json`](../../../layers/01-business-decomposition/schema.output.json).

## Inputs (from orchestration node)

```json
{
  "upstream_refs": [{"layer": "00-bootstrap", "artifact_path": "intent/bootstrap/2026-04-25-...md"}],
  "overrides": {
    "target_url": "https://example.com",
    "manual_brief": null
  }
}
```

## Steps

1. **Verify the bootstrap report.** Read the upstream artifact path. If the bootstrap report shows missing required tools (`page_extraction`, `agent_runtime`), abort with a clear error.
2. **Extract the live site.** Run Defuddle against `target_url`:
   ```powershell
   npx --yes defuddle-cli "$target_url" --json | Out-File -Encoding utf8 (Join-Path $env:TEMP "defuddle-extract.json")
   ```
   If extraction fails, retry once with `--strict false`. If that also fails, surface the error and stop.
3. **Crawl the top navigation.** Re-run Defuddle on each link in the extracted top-nav (cap at 10 pages) so we have evidence beyond the home page.
4. **Identify business functions.** Read the extracted markdown from each crawled page and identify business functions. Each function gets:
   - A short kebab-case `id` (e.g., `first-time-visit`, `birthday-bookings`).
   - A human `name`.
   - A `description` summarising what the function does for visitors / members.
   - At least one `evidence_ref`: a quote from the live site, or a URL to the page on which the function appears.
5. **Tier each function.** Assign every function to exactly one of:
   - `conversion` — first-time visitor → paying customer (e.g., First Time, Memberships, Coaching, Group Bookings, Gift Cards, Contact Us).
   - `consideration` — building familiarity / trust before purchase (e.g., Services & Facilities, Operating Times, Events, Community Engagement).
   - `retention` — keeping existing members engaged and renewed (e.g., Certifications, Membership management, Waivers).
6. **Extract tone.** Read the home page + 2-3 representative pages and write:
   - `voice` — 1-2 sentences describing the brand voice.
   - `register` — pick one of: formal, informal, playful, technical, warm, authoritative.
   - `examples` — 3-5 verbatim sentences from the site that exemplify the voice.
7. **Catalog assets.** Note logo URLs, hero images, social links, and any PDFs (waivers, terms) referenced.
8. **Apply manual brief if supplied.** If `overrides.manual_brief` is non-null, parse it as freeform markdown and use it to override or augment any of the above. Set `body.manual_brief_used: true` in the output. Conflicts default to the brief; flag them in evidence_refs with `source: manual_brief`.
9. **Write the artifact.** Write to `intent/decompositions/{site-slug}-{ISO-timestamp}.md`. Use the template at [`intent/decompositions/_template.md`](../../../intent/decompositions/_template.md) as the shape. The site-slug is derived from `target_url` host (e.g., `crankclimbing-com-au`).
10. **Reply with the artifact path.** Final line of your response = the repo-relative path. Nothing else.

## Output template

See [`intent/decompositions/_template.md`](../../../intent/decompositions/_template.md). Frontmatter is YAML; body is human-readable markdown that mirrors the frontmatter for review.

## Lock-once

Never edit a prior decomposition. To revise, write a new file with `supersedes: <prior_artifact_id>`.

## Failure modes

| Failure | Recovery |
|---|---|
| `target_url` returns 4xx/5xx | Surface to operator; do not invent content. |
| Defuddle returns no extractable text | Retry once with `--strict false`; if still empty, abort. |
| Tier assignment ambiguous | Default to `consideration`; flag in `evidence_refs`. |
| Tone examples can't be found verbatim | Quote the closest match and prepend `[~paraphrase]` in the `examples` array. |
