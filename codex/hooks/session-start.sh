#!/bin/bash
# Codex CLI SessionStart hook: register source with spreka server.

if ! command -v jq &>/dev/null; then
  echo '{"error": "jq is required but not installed"}' >&2
  exit 1
fi

INPUT=$(cat)
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

# Health check: if unreachable, skip silently.
if ! curl -s --max-time 2 "$SPREKA_URL/health" > /dev/null 2>&1; then
  exit 0
fi

# Note: pipe to curl -d @- instead of -d "$var" to avoid
# unicode corruption on Windows (Git Bash / MSYS2).
jq -n --arg source "$SOURCE" '{source: $source, has_stop_hook: false}' \
  | curl -s -X POST "$SPREKA_URL/register-hook" \
  -H 'Content-Type: application/json' \
  -d @- \
  > /dev/null 2>&1
