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

# Resolve spreka server URL from .mcp.json or fall back to default.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MCP_URL=$(jq -r '.mcpServers.spreka.url // ""' "$PLUGIN_ROOT/.mcp.json" 2>/dev/null)
if [ -n "$MCP_URL" ]; then
  SPREKA_URL="${MCP_URL%/mcp}"
else
  SPREKA_URL="${SPREKA_URL:-http://localhost:9100}"
fi

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
