---
name: ai-evaluation
description: Create, run, or review bilingual AI evaluations for profile extraction, service discovery, safety, non-fabrication, and provider behavior.
---

# AI Evaluation

Use for prompt, model, provider, extraction, search, or AI-adapter changes.

1. Read the relevant JSON Schema, prompt registry entry, dataset, rubric, and baseline.
2. Use synthetic or explicitly consented data only.
3. Run deterministic checks first: schema validity, locale, safety flags, required fields, limits, and provider failure handling.
4. Grade relevance, groundedness, helpfulness, follow-up quality, and non-fabrication with the rubric.
5. Compare with the named baseline and report scenario-level regressions; aggregate scores cannot hide critical failures.
6. Record prompt version, provider/model, adapter revision, dataset version, rubric version, latency, cost, failures, and rollback target.

Never treat fluent language as evidence of correctness. Critical safety, privacy, schema, and non-fabrication failures block release.
