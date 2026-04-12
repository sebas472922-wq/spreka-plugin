#!/bin/bash
# Claude Code Stop hook: extract last assistant message from transcript,
# then send beep + speak via MCP JSON-RPC.
# See docs/specs/final_report.md for full specification.

if ! command -v jq &>/dev/null; then
  echo '{"error": "jq is required but not installed"}' >&2
  exit 1
fi

INPUT=$(cat)

# Prevent infinite loop: if stop_hook_active, do nothing
STOP_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false')
if [ "$STOP_ACTIVE" = "true" ]; then
  exit 0
fi

SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // ""')
SOURCE="$(hostname)-${SESSION_ID:0:8}"

# Resolve spreka server URL.
# Priority: ~/.claude.json (user scope, set via claude mcp add) > default
USER_MCP_URL=$(jq -r '.mcpServers.spreka.url // ""' ~/.claude.json 2>/dev/null)
SPREKA_URL="${USER_MCP_URL:+${USER_MCP_URL%/mcp}}"
SPREKA_URL="${SPREKA_URL:-http://localhost:9100}"

# Extract last assistant message from transcript (max 200 chars)
TRANSCRIPT_FILE=$(cat "/tmp/spreka-transcript-${SOURCE}" 2>/dev/null)
LAST_MESSAGE=""

if [ -n "$TRANSCRIPT_FILE" ] && [ -f "$TRANSCRIPT_FILE" ]; then
  if command -v tac &>/dev/null; then
    REVERSE_CMD="tac"
  else
    REVERSE_CMD="tail -r"
  fi

  LAST_MESSAGE=$($REVERSE_CMD "$TRANSCRIPT_FILE" | while IFS= read -r line; do
    TYPE=$(echo "$line" | jq -r '.type // ""' 2>/dev/null)
    if [ "$TYPE" = "assistant" ]; then
      echo "$line" | jq -r '
        [.message.content[] | select(.type == "text") | .text] |
        join(" ") | .[0:200]
      ' 2>/dev/null
      break
    fi
  done)

  # Clean up temp file
  rm -f "/tmp/spreka-transcript-${SOURCE}"
fi

# Send beep + final speak via MCP JSON-RPC
JSON_PAYLOAD=$(jq -n --arg text "${LAST_MESSAGE:-}" --arg source "$SOURCE" '{
  jsonrpc: "2.0",
  method: "tools/call",
  id: 1,
  params: {
    name: "speak",
    arguments: {text: $text, source: $source, beep: true, final: true}
  }
}')
curl -s -X POST "$SPREKA_URL/mcp" \
  -H 'Content-Type: application/json' \
  -d "$JSON_PAYLOAD" \
  > /dev/null 2>&1
