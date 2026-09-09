# Core Evaluation Dataset v1

`core.jsonl` contains synthetic scenarios for the first user and professional journeys.

Each line is one JSON object with:

- stable scenario ID;
- scenario type;
- requested locale;
- user input;
- expected properties, not an exact answer;
- criticality.

Exact wording should not be required unless the product contract explicitly requires it. Graders should evaluate behavior and structured fields.

Add cases when a production or staging failure reveals a missing behavior. Never add private user content without consent and data-handling review.
