#!/bin/bash
# Claude Code Stop hook: notify user that agent finished responding.
# Sends beep only (no speech) — the last message is often long text/tables.
# LLM can optionally speak a summary via speak(final=true) in the Skill.

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

# Send beep-only notification via MCP JSON-RPC (tools/call speak)
JSON_PAYLOAD=$(jq -n --arg source "$SOURCE" '{
  jsonrpc: "2.0",
  method: "tools/call",
  id: 1,
  params: {
    name: "speak",
    arguments: {source: $source, beep: true, final: true, text: ""}
  }
}')
curl -s -X POST "$SPREKA_URL/mcp" \
  -H 'Content-Type: application/json' \
  -d "$JSON_PAYLOAD" \
  > /dev/null 2>&1
