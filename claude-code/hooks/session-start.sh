#!/bin/bash
# Claude Code SessionStart hook: check spreka server health and register source.
# Source = hostname + session_id (from stdin JSON, all hooks).

if ! command -v jq &>/dev/null; then
  echo '{"error": "jq is required but not installed"}' >&2
  exit 1
fi

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // ""')
SOURCE="$(hostname)-${SESSION_ID:0:8}"

# Resolve spreka server URL.
# Priority: ~/.claude.json (user scope, set via claude mcp add) > default
USER_MCP_URL=$(jq -r '.mcpServers.spreka.url // ""' ~/.claude.json 2>/dev/null)
SPREKA_URL="${USER_MCP_URL:+${USER_MCP_URL%/mcp}}"
SPREKA_URL="${SPREKA_URL:-http://localhost:9100}"

# Health check: verify spreka server is reachable (2 second timeout).
# If unreachable, skip registration silently — plugin has no effect this session.
if ! curl -s --max-time 2 "$SPREKA_URL/health" > /dev/null 2>&1; then
  exit 0
fi

# Register with spreka server that this source has a Stop hook.
# Note: pipe to curl -d @- instead of -d "$var" to avoid
# unicode corruption on Windows (Git Bash / MSYS2).
jq -n --arg source "$SOURCE" '{source: $source, has_stop_hook: true}' \
  | curl -s -X POST "$SPREKA_URL/register-hook" \
  -H 'Content-Type: application/json' \
  -d @- \
  > /dev/null 2>&1
