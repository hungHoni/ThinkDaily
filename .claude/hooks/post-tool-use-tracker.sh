#!/bin/bash
# PostToolUse hook — tracks edited files for context

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
SESSION_ID="${CLAUDE_SESSION_ID:-default}"
CACHE_DIR="$PROJECT_DIR/.claude/tsc-cache/$SESSION_ID"

mkdir -p "$CACHE_DIR"

# Read file path from stdin (JSON)
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

TIMESTAMP=$(date +%s)
echo "$TIMESTAMP:$FILE_PATH" >> "$CACHE_DIR/edited-files.log"

exit 0
