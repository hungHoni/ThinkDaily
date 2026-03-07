#!/bin/bash
# UserPromptSubmit hook — activates skills based on prompt keywords

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run the TypeScript logic
node "$SCRIPT_DIR/skill-activation-prompt.js" 2>/dev/null || \
  npx --prefix "$SCRIPT_DIR" ts-node "$SCRIPT_DIR/skill-activation-prompt.ts" 2>/dev/null

exit 0
