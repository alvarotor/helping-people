# Domain Model

## Core model

The central model is user-centered rather than role-centered:

```text
User
├── Identity and preferences
├── zero or one ProfessionalProfile
│   └── one or more ProfessionalServices
├── zero or more ServiceRequests
│   ├── Matches
│   └── ContactRequests
└── Conversations
    └── Messages
```

The same user may own a professional profile and create service requests. No entity should require a permanent “worker” or “client” role.

## User

The user is the stable account-level identity used for ownership and authorization.

Conceptual attributes:

- stable identifier;
- email and authentication linkage;
- preferred locale;
- timezone;
- consent and notification preferences;
- administrative authorization attributes;
- created, updated, and deactivated timestamps.

The authentication service owns credentials, sessions, and authentication lifecycle. The application API consumes the authentication contract and owns product behavior associated with the user.

## ProfessionalProfile

A user may create at most one primary professional profile initially. The design should not prevent multiple profiles later if a real product need appears.

Conceptual attributes:

- owner user ID;
- display/business name;
- introduction or biography;
- service categories;
- experience;
- languages;
- service area;
- location representation;
- contact preferences;
- media or verification references when introduced;
- lifecycle state;
- draft and published versions or timestamps;
- moderation state;
- audit metadata.

The profile is not public merely because it exists. Search and public pages use only a published, non-suspended representation.

## ProfessionalService

Professional services separate what a professional offers from the profile identity.

Conceptual attributes:

- professional profile ID;
- normalized service category;
- localized display information;
- description;
- coverage radius or service regions;
- availability summary;
- optional pricing information;
- active/inactive state.

This allows one professional to offer several categories without flattening all categories into one free-text field.

## ServiceRequest

A service request represents the user's need.

Conceptual attributes:

- requester user ID;
- original user message;
- normalized category and constraints;
- location and location precision;
- preferred locale;
- timing or urgency;
- request lifecycle state;
- creation and expiry timestamps;
- privacy and retention metadata.

The original message should be retained separately from AI-extracted fields so the system can explain, reprocess, or audit extraction decisions without pretending the extraction is the original truth.

## Match

A match is generated from a service request and professional service.

Conceptual attributes:

- service request ID;
- professional service ID;
- ranking score and score version;
- reasons or explainable signals suitable for the UI;
- distance estimate when available;
- generated timestamp;
- visibility and expiry state.

Scores are recommendations and must not be presented as guarantees or objective professional quality ratings.

## ContactRequest

A contact request records an explicit transition from discovery to communication.

Conceptual attributes:

- requester user ID;
- professional owner user ID;
- optional service request ID;
- optional match ID;
- status;
- creation, response, and expiry timestamps;
- consent and privacy metadata.

The initial implementation may create a conversation immediately after an accepted contact request, but the domain keeps the concepts separate so trust, throttling, and moderation can evolve.

## Conversation and Message

A conversation contains participants and messages. The backend enforces participant access, block rules, reporting rules, rate limits, and retention policies.

Conceptual conversation attributes:

- participant user IDs;
- related service request or contact request;
- lifecycle state;
- unread/read state projections;
- moderation state;
- created and last-activity timestamps.

Messages must not expose private contact details automatically. Future contact sharing should be an explicit, auditable action.

## Admin and moderation

Administrative access is cross-cutting authorization, not a business relationship. Admins may inspect or modify resources only through explicit audited operations. The admin frontend is a separate client, but the backend remains the authority.

## Localization and international readiness

Domain records should store stable codes and normalized values, not only translated display strings.

Use:

- stable category codes;
- locale-aware display names;
- country and region codes;
- timezone identifiers;
- currency codes where pricing exists;
- localized system and AI responses;
- explicit formatting at the frontend boundary.

Spanish and English are the first locales. The API should carry locale where behavior depends on it, but business records should not be duplicated solely because a user changes language.
