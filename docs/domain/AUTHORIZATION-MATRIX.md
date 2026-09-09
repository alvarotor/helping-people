# Authorization Matrix

The backend is the authority for authorization. Frontend route visibility is only a user-experience concern and never replaces backend checks.

## Actors

| Actor | Meaning |
|---|---|
| Public | Unauthenticated visitor |
| Authenticated user | Signed-in person |
| Resource owner | Authenticated user who owns the resource |
| Participant | User authorized by membership in a conversation or interaction |
| Professional owner | User who owns a professional profile or service |
| Administrator | User with explicit administrative authorization |
| Internal service | Authenticated service-to-service caller with a narrow contract |

## Resource matrix

| Resource/action | Public | Authenticated | Owner/professional | Participant | Admin | Internal service |
|---|---:|---:|---:|---:|---:|---:|
| Read published professional profile | Yes | Yes | Yes | Yes | Yes | No |
| Create service request | No | Yes | Yes | No | Yes, audited | No |
| Read own service requests | No | Yes | Yes | No | Yes, audited | No |
| Read another user's private request | No | No | No | No | Yes, audited | No |
| Create professional profile draft | No | Yes | Yes | No | Yes, audited | No |
| Edit professional profile draft | No | No | Yes | No | Yes, audited | No |
| Submit profile for review | No | No | Yes | No | Yes, audited | No |
| Publish profile | No | No | Yes, after rules pass | No | Yes, audited | No |
| Unpublish own profile | No | No | Yes | No | Yes, audited | No |
| Suspend/reinstate profile | No | No | No | No | Yes, audited | No |
| Search professionals | Limited public projections | Yes | Yes | No | Yes | No |
| Create contact request | No | Yes | Yes | No | Yes, audited | No |
| Accept/decline contact request | No | No | Professional recipient | No | Yes, audited | No |
| Read conversation | No | No | No | Yes | Yes, audited | No |
| Send message | No | No | No | Yes, if not blocked | Yes, audited | No |
| Block another user | No | Yes | Yes | Yes | Yes, audited | No |
| Report profile/message/user | No | Yes | Yes | Yes | Yes, audited | No |
| Manage own locale/preferences | No | Yes | Yes | Yes | Yes, audited | No |
| Manage users and moderation | No | No | No | No | Yes, audited | No |
| Resolve authentication session | No | No | No | No | No | Auth contract only |
| Generate AI response | No | No | No | No | No | API-authorized only |

## Authorization requirements

- Every protected endpoint derives the actor from a validated session or explicit service credential.
- Resource ownership and participant membership are checked server-side.
- Admin access is checked server-side for every administrative operation.
- Administrative reads and writes are auditable.
- Blocking is enforced consistently for contact, conversation, and message operations.
- Public projections must exclude private phone, email, address, internal IDs, moderation notes, and other restricted fields.
- Service-to-service credentials are scoped to the minimum required operation.
- Authorization failures use stable public error categories and do not leak internal details.
