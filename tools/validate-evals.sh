#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

python3 - <<'PY'
import json
from pathlib import Path

dataset = Path("evals/datasets/v1/core.jsonl")
seen = set()
for line_number, line in enumerate(dataset.read_text().splitlines(), 1):
    if not line.strip():
        continue
    item = json.loads(line)
    required = {"id", "type", "locale", "input", "expected", "criticality"}
    missing = required - item.keys()
    if missing:
        raise SystemExit(f"{dataset}:{line_number}: missing {sorted(missing)}")
    if item["id"] in seen:
        raise SystemExit(f"{dataset}:{line_number}: duplicate id {item['id']}")
    seen.add(item["id"])
    if item["locale"] not in {"es", "en"}:
        raise SystemExit(f"{dataset}:{line_number}: unsupported locale")
    if item["criticality"] not in {"normal", "critical"}:
        raise SystemExit(f"{dataset}:{line_number}: unsupported criticality")
print(f"dataset ok: {dataset} ({len(seen)} scenarios)")
PY
