"""Summarise the JSON written by `npx hyperframes timeline --json`.

Usage: python3 examples/timeline_summary.py [timeline.json]

The cited sources describe the output (tracks, clips, starts, ends, what plays)
but do not publish its schema, so this prints structure rather than assuming
field names. The one documented flag, _meta.updateAvailable, is reported if present.
"""
import json
import sys
from pathlib import Path

path = Path(sys.argv[1] if len(sys.argv) > 1 else "timeline.json")
if not path.exists():
    sys.exit(f"not found: {path} (run examples/project-check.sh first)")

with path.open() as fh:
    data = json.load(fh)

print(f"file: {path} ({path.stat().st_size} bytes)")

if isinstance(data, dict):
    meta = data.get("_meta")
    if isinstance(meta, dict) and meta.get("updateAvailable") is True:
        print("note: _meta.updateAvailable is true; the project pins an older CLI")


def describe(value):
    if isinstance(value, list):
        inner = type(value[0]).__name__ if value else "empty"
        return f"list of {len(value)} ({inner})"
    if isinstance(value, dict):
        return f"dict with {len(value)} keys"
    return f"{type(value).__name__}: {str(value)[:60]}"


if isinstance(data, dict):
    for key, value in data.items():
        print(f"  {key}: {describe(value)}")
        if isinstance(value, list) and value and isinstance(value[0], dict):
            print(f"    first item keys: {sorted(value[0].keys())}")
elif isinstance(data, list):
    print(f"  {describe(data)}")
    if data and isinstance(data[0], dict):
        print(f"  first item keys: {sorted(data[0].keys())}")
else:
    print(f"  {describe(data)}")
