# Application Contracts

This directory contains machine-readable contracts shared by application services and clients.

## Layout

```text
contracts/
├── openapi/       # browser-facing and internal HTTP contracts
├── schemas/v1/    # JSON Schemas for domain and structured AI payloads
├── proto/         # protobuf contracts only when an approved decision requires them
└── generated/     # generated clients and bindings; never hand-edit
```

## Ownership

- The API service owns application HTTP behavior and its OpenAPI contract.
- The auth service owns authentication behavior and its auth contract.
- The AI adapter owns provider integration behavior; its structured inputs and outputs are defined here before implementation.
- The frontend applications consume contracts and must not invent incompatible response shapes.
- Generated artifacts are derived from source contracts and must be regenerated in the same change.

## Current transport decision

The backend-to-AI-adapter boundary uses gRPC with protobuf. This is the required internal connection for AI services and the backend. JSON Schemas in `schemas/v1/` define the canonical meaning of structured payloads independently of transport; protobuf defines the RPC envelope and transport-level metadata.

Generated Go/Python bindings will be added once the language toolchain and generation command are approved. They must be derived from `proto/ai.proto` and never hand-edited.

## Validation

Contract validation must eventually include:

- OpenAPI syntax and semantic validation;
- JSON Schema validation;
- generated artifact freshness;
- provider/consumer compatibility tests;
- integration tests against the running Compose stack.

The current syntax validation command is:

```bash
./tools/validate-contracts.sh
```

Semantic OpenAPI validation and generated-client freshness checks will be added when the implementation toolchain is selected.
