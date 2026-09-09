# API Service

Minimal API service scaffold. It currently exposes process liveness, readiness, and health endpoints only. Product routes are added through approved OpenSpec changes and the application OpenAPI contract.

## Local

```bash
go run ./cmd/api
go test ./...
```

Default port: `8081`.
