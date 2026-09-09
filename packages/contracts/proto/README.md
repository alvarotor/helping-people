# Protobuf Contracts

The backend connects to the AI adapter through gRPC. `ai.proto` is the canonical RPC contract.

The protobuf messages carry transport-safe envelopes. Structured AI payloads are JSON strings in the RPC response and must be validated by the backend against the versioned JSON Schemas in `../schemas/v1/`.

The AI adapter is stateless and must not write application-domain data. The backend remains responsible for authorization, persistence, profile merging, request lifecycle, and publication decisions.

Operational requirements:

- use explicit RPC deadlines;
- authenticate service-to-service metadata;
- enforce request and response size limits;
- expose standard gRPC health behavior separately from business RPCs;
- preserve unknown protobuf fields for forward compatibility;
- regenerate bindings in every consumer/provider implementation change.
