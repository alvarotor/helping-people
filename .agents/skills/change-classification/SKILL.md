---
name: change-classification
description: Classify a requested change as application-local, platform-local, contract-preserving, or cross-repository before implementation.
---

# Change Classification

Use before writing an OpenSpec proposal or implementation plan.

Inspect the request, current contracts, ownership documents, and affected repository instructions. Classify it as:

- application-local: internal behavior with no external boundary change;
- platform-local: infrastructure or operations behavior with no application contract change;
- contract-preserving: implementation of an approved existing contract;
- cross-repository: a new or changed route, RPC, schema, auth rule, environment contract, database ownership boundary, service dependency, deployment behavior, or observability requirement.

For uncertain cases, classify conservatively as cross-repository and explain why. List affected repositories, contracts, data, security boundaries, migrations, tests, and rollback concerns. Do not implement until the approval path is clear.
