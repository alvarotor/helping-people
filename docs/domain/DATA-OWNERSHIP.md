# Data Ownership Map

The application may initially use one PostgreSQL server and one Compose deployment. Physical co-location does not change logical ownership.

## Ownership table

| Data area | Owning component | Allowed writers | Consumers |
|---|---|---|---|
| Users, sessions, authentication identities | Auth service | Auth service migrations and handlers | API through auth contract, web, admin |
| User locale and application preferences | API service initially | API service | Web, admin, AI adapter through request context |
| Professional profiles and professional services | API service | API service | Web, admin, search, AI adapter through contracts |
| Service requests | API service | API service | Web, admin, matching/search |
| Matches and ranking evidence | API service | API service matching workflow | Web, admin, analytics |
| Contact requests and conversations | API service | API service | Web, admin, moderation |
| Messages and reports | API service | API service | Web, admin, moderation, audit tooling |
| Prompt versions and AI evaluation metadata | Application repository and API service policy | Git-reviewed changes; API-controlled publish workflow if runtime editing is introduced | AI adapter, admin, evaluation tooling |
| Embeddings and search indexes | API/search subsystem | API service or explicit indexing job | Search subsystem only |
| Logs, metrics, traces, deployment records | Platform/observability | Services emit; platform collects | Operators and review tooling |

## Boundary rules

- A service must not write another service's tables directly.
- Shared PostgreSQL does not imply shared schema ownership.
- Auth data is accessed through an explicit auth contract, not ad hoc application queries.
- The API owns application-domain writes and authorization decisions.
- The AI adapter is stateless by default and does not become a second source of truth for profiles or requests.
- Search indexes and embeddings are derived data and can be rebuilt from authoritative application data.
- Platform systems observe and run the application; they do not own application business data.

## Migration rules

- Schema changes use explicit, reviewable migrations.
- Prefer additive expand/migrate/contract changes for deployed systems.
- Derived data must have a rebuild/backfill procedure.
- Destructive migrations require an explicit backup, rollback, and approval plan.
- Test data is disposable and must never use production credentials or user data.

## Future extraction rule

A component may receive its own database only when there is a measured reason such as scaling, isolation, security, or independent ownership. Extraction must preserve the public contract where practical and must include a data migration plan.
