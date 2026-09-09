# AI and Product Evaluation System

This directory defines how AI-assisted product behavior is evaluated before release. It is part of the product quality system, not an optional experiment folder.

## Goals

Evaluate whether the system:

- responds in the requested Spanish or English locale;
- extracts only information supported by the user input;
- asks useful follow-up questions when information is missing;
- returns schema-valid structured data;
- recommends relevant professionals without fabricating them;
- handles uncertainty and safety-sensitive situations responsibly;
- remains useful when a provider is slow, unavailable, or inconsistent;
- stays within acceptable latency and cost budgets.

## Layout

```text
evals/
├── datasets/       # versioned representative inputs and expected properties
├── scenarios/      # scenario-specific instructions and test plans
├── graders/        # deterministic and model-assisted scoring rules
├── baselines/      # approved model/prompt/provider snapshots
└── README.md
```

## Evaluation types

### Deterministic checks

- JSON Schema validation;
- locale and language checks;
- required field and safety-flag checks;
- no-result and malformed-output handling;
- latency and token/cost budgets;
- provider timeout and retry behavior.

### Human or model-assisted grading

- helpfulness;
- relevance;
- groundedness;
- clarity;
- follow-up question quality;
- explanation quality;
- non-fabrication;
- professional-result usefulness.

Model-assisted graders must not be the only gate for safety or schema correctness.

## Workflow

```text
write scenario
→ run against candidate
→ run deterministic checks
→ grade behavior
→ compare with baseline
→ review failures
→ approve or reject release
```

Evaluation datasets must not contain real private user data. Use synthetic or explicitly consented data only.
