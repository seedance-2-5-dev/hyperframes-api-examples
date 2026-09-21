#!/usr/bin/env bash
# Install the HyperFrames agent skills.
# Install lines follow hyperframes.heygen.com and the mcpservers.org entry.
set -euo pipefail

if ! command -v npx >/dev/null 2>&1; then
  echo "npx not found; install Node.js first" >&2
  exit 1
fi

if [ "${1:-}" = "--entry-only" ]; then
  # Only the entry skill, which routes to the domain skills.
  npx skills add https://github.com/heygen-com/hyperframes --skill hyperframes
else
  # All skills, full depth (the line on the HyperFrames home page).
  npx skills add heygen-com/hyperframes --full-depth
fi

cat <<EOF

Skills installed. Open a project directory in your AI coding assistant and ask, for example:

  Make a 20-second product launch video for this repository. Start from the README.

The agent reads the hyperframes entry skill first and routes the request.
Continue from the first version rather than starting over (quickstart, step 3).
EOF
