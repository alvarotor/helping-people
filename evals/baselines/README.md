# Evaluation Baselines

Baselines are immutable records of an approved prompt/provider/model/adapter combination evaluated against a named dataset version.

No baseline exists yet because the AI adapter has not been implemented or selected with a concrete provider configuration.

When the first baseline is created, record:

- baseline ID;
- prompt versions;
- model/provider identifiers;
- adapter commit;
- dataset and rubric versions;
- deterministic results;
- grader results;
- latency and cost measurements;
- known failures and accepted trade-offs;
- rollback target.
