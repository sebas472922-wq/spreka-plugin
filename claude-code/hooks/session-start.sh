#!/bin/bash
# Claude Code SessionStart hook: check spreka server health and register source.
# Source = hostname + session_id (from stdin JSON, all hooks).

if ! command -v jq &>/dev/null; then
  echo '{"error": "jq is required but not installed"}' >&2
  exit 1
fi

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // ""')
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // ""')
SOURCE="$(hostname)-${SESSION_ID:0:8}"

# Resolve spreka server URL from plugin userConfig or fall back to default.
SPREKA_URL="${CLAUDE_PLUGIN_OPTION_SERVER_URL:-http://localhost:9100}"

# Health check: verify spreka server is reachable (2 second timeout).
# If unreachable, skip registration silently — plugin has no effect this session.
if ! curl -s --max-time 2 "$SPREKA_URL/health" > /dev/null 2>&1; then
  exit 0
fi

# Register with spreka server that this source has a Stop hook.
JSON_PAYLOAD=$(jq -n --arg source "$SOURCE" '{source: $source, has_stop_hook: true}')
curl -s -X POST "$SPREKA_URL/register-hook" \
  -H 'Content-Type: application/json' \
  -d "$JSON_PAYLOAD" \
  > /dev/null 2>&1

# Save transcript_path for the Stop hook.
if [ -n "$TRANSCRIPT_PATH" ]; then
  echo "$TRANSCRIPT_PATH" > "/tmp/spreka-transcript-${SOURCE}"
fi
