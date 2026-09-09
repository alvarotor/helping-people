---
name: contract-design
description: Design or review OpenAPI, protobuf, and JSON Schema contracts for HelpingPeopleNow while preserving ownership and compatibility rules.
---

# Contract Design

Use for externally visible API, gRPC, event, structured AI, or schema changes.

1. Read the domain model, authorization matrix, data ownership map, and compatibility policy.
2. Confirm the owning service and whether the change has an approved OpenSpec proposal.
3. Define observable behavior, authentication, authorization, errors, validation, limits, lifecycle states, and failure behavior.
4. Update the appropriate machine-readable contract rather than relying on prose.
5. For backend-to-AI communication, preserve the gRPC/protobuf boundary and use versioned JSON Schemas for structured semantics.
6. Prefer additive evolution; document migrations and deprecation for breaking changes.
7. Validate syntax and update provider/consumer tests or generated bindings when implementation exists.

Do not let frontend types, database structs, or model output silently become the public contract.
