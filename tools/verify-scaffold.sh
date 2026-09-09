#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

echo "== contracts"
./tools/validate-contracts.sh

echo "== evaluations"
./tools/validate-evals.sh

echo "== Go API"
(cd apps/api && go test ./...)

echo "== Python AI syntax"
PYTHONPYCACHEPREFIX="${TMPDIR:-/tmp}/helping-people-pycache" \
  python3 -m py_compile apps/ai/main.py packages/contracts/generated/python/ai_pb2.py packages/contracts/generated/python/ai_pb2_grpc.py

echo "== required service files"
for path in \
  apps/web/package.json \
  apps/admin/package.json \
  apps/api/go.mod \
  apps/auth/package.json \
  apps/ai/requirements.txt \
  packages/contracts/proto/ai.proto; do
  test -f "$path"
done

echo "scaffold verification passed"
