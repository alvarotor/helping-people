# HelpingPeopleNow Application Instructions

These instructions apply to the application repository and all services inside it.

## Product rules

HelpingPeopleNow helps people find local tradespeople and handymen easily. The first market is Spain, with Spanish and English required from the beginning and future international expansion expected.

A person may both request help and offer professional services. Do not encode a permanent worker-versus-client identity model. Professional profiles are optional and become public only after explicit preview and publish.

Contact begins on the platform. Do not expose phone numbers or email addresses by default.

## Repository ownership

This repository owns:

- the public web application;
- the separate admin web application;
- the application API and domain behavior;
- authentication integration;
- the AI and embedding adapter;
- OpenAPI/protobuf/JSON-schema contracts;
- AI evaluation datasets and graders;
- OpenSpec specifications and change proposals.

Infrastructure and deployment implementation belongs to `../helping-people-platform/`.

## Cross-repository work

When a change affects Compose, image names, ports, routing, environment variables, secrets, healthchecks, observability, deployment, scaling, or infrastructure, classify it as cross-repository.

For cross-repository work, read:

1. `docs/foundation/WORKSPACE.md`;
2. this file;
3. `../helping-people-platform/AGENTS.md`;
4. the relevant OpenSpec change.

Do not change platform files from this repository unless the approved change explicitly includes platform work. Prepare a linked platform change instead.

## Contract rules

- Browser-facing APIs use OpenAPI unless an approved decision says otherwise.
- Internal RPC uses protobuf only when it provides a clear benefit.
- Structured AI results use versioned schemas and validation.
- A route, request/response shape, authentication requirement, RPC, event, database ownership boundary, or service dependency is a contract change.
- Contract changes require an approved OpenSpec change before implementation.
- Generated artifacts must be regenerated and verified in the same change.

## AI rules

- Treat model output as untrusted external input.
- Do not use undocumented text markers as a data interchange format.
- Prompts must be versioned and evaluated.
- Do not change a production prompt without recording its version, evaluation result, and rollback path.
- Do not add providers or fallback behavior without measuring quality, cost, latency, and failure behavior.

## Data and security rules

- Define data ownership before creating a table or write path.
- Use explicit migrations; do not rely on uncontrolled startup schema mutation.
- Never commit credentials, live environment files, tokens, certificates, or personal data.
- Do not use production data in local tests.
- Validate authorization at the backend boundary; frontend visibility is not authorization.

## Implementation rules

- Prefer small vertical slices with end-to-end value.
- Keep service boundaries explicit even while services share a repository.
- Keep root-level shared code and configuration small.
- Add tests and documentation with behavior changes.
- Preserve backward compatibility unless the OpenSpec change includes migration and rollback planning.

## Verification

Before presenting work for review, run the narrowest relevant checks, then the repository-wide checks when practical. Report commands run, results, known limitations, and any unverified assumptions.

Do not claim production verification unless it was explicitly authorized and actually performed.
