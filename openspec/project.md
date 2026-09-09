# HelpingPeopleNow OpenSpec Constitution

## Mission

HelpingPeopleNow helps people find trustworthy local tradespeople and handymen easily. The first market is Spain, with Spanish and English required from the beginning and future international expansion expected.

## Product principles

- Optimize for a person who is not technical and may be using the site for the first time.
- Keep the primary journey simple: explain a need, find suitable professionals, understand them, and start a platform conversation.
- A person may request services, offer professional services, or do both.
- Professional profiles are optional and must pass preview plus explicit publish before becoming public.
- Contact starts on the platform. Private contact details are not exposed by default.
- AI must assist users without hiding uncertainty or inventing facts.

## Architecture principles

- The application repository owns product behavior, application services, contracts, evaluations, and OpenSpec.
- The sibling platform repository owns Compose, deployment, observability, environments, and infrastructure.
- A runtime service and a Git repository are different concepts. Services may share the application repository while retaining clear runtime boundaries.
- Browser-facing APIs use OpenAPI unless an approved decision says otherwise.
- The backend-to-AI-adapter boundary uses gRPC with protobuf. The protobuf contract defines transport; versioned JSON Schemas define structured payload semantics.
- Database ownership, migrations, and write paths must be explicit.
- Compose is the initial runtime. Kubernetes is a future option justified by measured needs.

## Change governance

- Every meaningful change is explored, classified, proposed, approved, implemented, verified, reviewed, and then merged.
- Application-local changes may begin in the application repository.
- Platform-local changes are proposed here and implemented in the platform repository.
- Any new or changed route, RPC, event, authorization requirement, environment contract, database ownership boundary, or service dependency is a cross-repository or contract change until proven otherwise.
- Cross-repository changes use one change ID and linked pull requests.
- No agent may silently invent or change a cross-repository contract.

## Agent governance

Agents may explore, plan, create proposals, implement approved work on isolated branches, run checks, and prepare reports.

Agents may not merge their own work, approve their own proposals, deploy production, modify production data, commit secrets, or perform destructive operations without explicit human approval.

## AI quality

- Model output is untrusted external input and must be schema-validated.
- Undocumented text markers are not acceptable application data protocols.
- Prompts and model/provider choices are versioned.
- AI changes require representative evaluations covering Spanish and English behavior, extraction, search relevance, hallucination, safety, latency, cost, and failure behavior.
- Runtime prompt editing, if introduced, must support draft, evaluation, approval, publish, monitoring, and rollback.

## Definition of done

A change is not complete until:

- the approved behavior is implemented;
- affected contracts and migrations are updated;
- tests and AI evaluations are updated where relevant;
- security, privacy, observability, and failure behavior are considered;
- repository-specific verification has passed;
- cross-repository verification has passed when applicable;
- documentation and OpenSpec status are updated;
- a human has reviewed and approved the result.
