# Database Package Boundary

The application owns its database schema and migrations. This directory is intentionally only a boundary marker during Phase 8; persistence is introduced through an approved OpenSpec change after the domain model and authorization rules are reviewed.

The platform repository will provide the local PostgreSQL container and connection wiring. Application services must receive connection details through environment variables and must not depend on platform-specific hostnames in code.
