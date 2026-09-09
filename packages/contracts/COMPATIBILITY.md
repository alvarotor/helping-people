# Contract Compatibility Policy

## Versioning

- Public HTTP contracts use `/v1/` for the initial stable surface.
- Additive response fields are preferred when clients tolerate unknown fields.
- Request fields are added as optional before becoming required.
- Removing or changing the meaning of a field is a breaking change.
- Breaking changes require a new version or an explicit expand/migrate/contract plan.
- AI schemas include a schema identifier and version when persisted or exchanged across service boundaries.
- Backend-to-AI communication uses the versioned protobuf package `helpingpeople.ai.v1`.

## Change requirements

Any change to a route, method, request, response, status code, error category, authentication requirement, event, RPC, or schema requires:

1. an approved OpenSpec change;
2. an updated machine-readable contract;
3. affected consumer and provider tests;
4. a migration or compatibility plan when existing data or clients are involved;
5. rollback considerations.

## gRPC compatibility

- Add new protobuf fields with new field numbers; never reuse a field number.
- Do not change the meaning or wire type of an existing field.
- Prefer additive RPCs and fields.
- Keep generated bindings in sync with the checked-in proto source.
- Backend and AI adapter provider/consumer tests must run against the same contract revision.
- Service-to-service authentication, deadlines, maximum message sizes, and health behavior are part of the operational contract even when they are not encoded in protobuf.

## Error contract

HTTP APIs use the `Problem` schema from the application OpenAPI document. Error responses must be safe for clients and must not leak stack traces, provider secrets, SQL, or internal topology.

## Generated artifacts

Generated clients and bindings are derived outputs. They must never be edited manually. CI will eventually fail when generated output is stale.
