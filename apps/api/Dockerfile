FROM golang:1.25-alpine AS build
WORKDIR /src
COPY apps/api/go.mod ./apps/api/
COPY apps/api ./apps/api
WORKDIR /src/apps/api
RUN CGO_ENABLED=0 go build -trimpath -ldflags='-s -w' -o /out/api ./cmd/api

FROM alpine:3.22
RUN adduser -D -H -u 10001 app
COPY --from=build /out/api /usr/local/bin/api
USER app
EXPOSE 8081
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD wget -qO- http://127.0.0.1:8081/livez || exit 1
ENTRYPOINT ["/usr/local/bin/api"]
