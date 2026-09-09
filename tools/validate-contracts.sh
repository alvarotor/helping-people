#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

python3 - <<'PY'
import json
from pathlib import Path

for path in Path("packages/contracts/schemas").rglob("*.json"):
    json.loads(path.read_text())
    print(f"json ok: {path}")

try:
    import yaml
except ModuleNotFoundError as exc:
    raise SystemExit("PyYAML is required to validate OpenAPI YAML") from exc

for path in Path("packages/contracts/openapi").glob("*.yaml"):
    yaml.safe_load(path.read_text())
    print(f"yaml ok: {path}")
PY
