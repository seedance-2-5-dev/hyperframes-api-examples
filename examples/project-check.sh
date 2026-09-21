#!/usr/bin/env bash
# For an existing HyperFrames project: probe the pinned CLI version and dump the timeline.
# Commands follow the hyperframes entry skill as shown on mcpservers.org.
set -euo pipefail

PROJECT_DIR="${1:-.}"
OUT="${2:-timeline.json}"

cd "$PROJECT_DIR"

if [ ! -f package.json ]; then
  echo "no package.json in $PROJECT_DIR; is this a scaffolded HyperFrames project?" >&2
  exit 1
fi

echo "1. Pinned CLI vs latest (read-only probe; keep the explicit '.')"
npx hyperframes@latest upgrade --project . --check || true

echo
echo "2. Timeline as JSON -> $OUT"
npx hyperframes timeline --json > "$OUT"

echo
echo "Done. Summarise it with: python3 examples/timeline_summary.py $OUT"
