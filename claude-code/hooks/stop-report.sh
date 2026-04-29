#!/bin/bash
# Claude Code Stop hook: send beep + last assistant message via MCP JSON-RPC.
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
USER_MCP_URL=$(jq -r '.mcpServers.spreka.url // ""' ~/.claude.json 2>/dev/null)
SPREKA_URL="${USER_MCP_URL:+${USER_MCP_URL%/mcp}}"
SPREKA_URL="${SPREKA_URL:-https://spreka.se-es.net}"

# Extract OAuth access token from Claude Code credential store (DCR-issued).
# When auth.mode=oauth on the server, requests must include Bearer token.
# When auth.mode=none (local server), no token is required and lookup returns empty.
SPREKA_TOKEN=$(jq -r --arg url "$SPREKA_URL/mcp" '
  (.mcpOAuth // {}) | to_entries
    | map(select(.value.serverUrl == $url))
    | .[0].value.accessToken // ""
' ~/.claude/.credentials.json 2>/dev/null)

AUTH_HEADER=()
[ -n "$SPREKA_TOKEN" ] && AUTH_HEADER=(-H "Authorization: Bearer $SPREKA_TOKEN")

# Extract last assistant message from stdin (no client-side truncation;
# server-side text.max_length_mcp handles the upper bound).
LAST_MESSAGE=$(echo "$INPUT" | jq -r '.last_assistant_message // ""')

# Send beep + final speak via MCP JSON-RPC.
# Note: pipe to curl -d @- instead of -d "$var" to avoid
# unicode corruption on Windows (Git Bash / MSYS2).
jq -n --arg text "${LAST_MESSAGE:-}" --arg source "$SOURCE" '{
  jsonrpc: "2.0",
  method: "tools/call",
  id: 1,
  params: {
    name: "speak",
    arguments: {text: $text, source: $source, beep: true, final: true}
  }
}' | curl -s -X POST "$SPREKA_URL/mcp" \
  -H 'Content-Type: application/json' \
  "${AUTH_HEADER[@]}" \
  -d @- \
  > /dev/null 2>&1
