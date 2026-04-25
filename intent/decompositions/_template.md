---
artifact_id: "{site-slug}-{ISO-timestamp}"
layer: "01-business-decomposition"
produced_at: "{ISO-8601 UTC}"
supersedes: null
upstream_refs:
  - layer: "00-bootstrap"
    artifact_id: "{bootstrap-artifact-id}"
body:
  target_url: "https://example.com"
  manual_brief_used: false
  tiers:
    conversion:
      - id: "first-time-visit"
        name: "First-time visitor flow"
        description: "Onboarding path for someone who has never visited the gym, including waiver, induction, and price options."
        evidence_refs:
          - source: live_url
            quote_or_url: "https://example.com/first-time"
    consideration:
      - id: "facilities-overview"
        name: "Facilities and services overview"
        description: "Description of climbing walls, ninja rigs, training rooms, and any retail / cafe offer."
        evidence_refs:
          - source: live_url
            quote_or_url: "https://example.com/facilities"
    retention:
      - id: "membership-management"
        name: "Membership management"
        description: "Self-service for active members: pause, cancel, update payment, view check-ins."
        evidence_refs:
          - source: live_url
            quote_or_url: "https://example.com/account"
  tone:
    voice: "Warm and welcoming; emphasises community and that anyone belongs."
    register: "warm"
    examples:
      - "Verbatim quote 1 from the live site."
      - "Verbatim quote 2."
      - "Verbatim quote 3."
  assets:
    - kind: logo
      url: "https://example.com/static/logo.svg"
    - kind: image
      url: "https://example.com/static/hero.jpg"
      note: "Hero photo on the homepage."
---

# Business Decomposition — {site-slug}

Mirror of the frontmatter for human review. Edit nothing — supersedes only.

## Conversion

- **First-time visitor flow** — onboarding path for someone who has never visited.
  - Evidence: <https://example.com/first-time>

## Consideration

- **Facilities and services overview** — climbing walls, ninja rigs, training rooms.
  - Evidence: <https://example.com/facilities>

## Retention

- **Membership management** — self-service account.
  - Evidence: <https://example.com/account>

## Tone

> Warm and welcoming; emphasises community and that anyone belongs.

Register: **warm**.

Verbatim examples:

- "Verbatim quote 1 from the live site."
- "Verbatim quote 2."
- "Verbatim quote 3."

## Assets

| Kind | URL | Note |
|---|---|---|
| logo | <https://example.com/static/logo.svg> | |
| image | <https://example.com/static/hero.jpg> | Hero photo on the homepage. |
