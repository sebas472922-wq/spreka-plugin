#!/bin/bash
# Claude Code PreToolUse hook (matcher: mcp__plugin_spreka_spreka__speak):
# Inject source (hostname + session_id) — overwrite LLM-provided value.

if ! command -v jq &>/dev/null; then
  echo '{"error": "jq is required but not installed"}' >&2
  exit 1
fi

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // ""')
SOURCE="$(hostname)-${SESSION_ID:0:8}"

echo "$INPUT" | jq --arg src "$SOURCE" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "allow",
    updatedInput: (.tool_input | .source = $src)
  }
}'
