#!/bin/bash
# Gemini CLI BeforeTool hook:
# Inject source (hostname + session_id) into speak tool_input.
# Gemini hooks receive session_id in stdin JSON.
# Note: Gemini uses "BeforeTool" instead of "PreToolUse".

if ! command -v jq &>/dev/null; then
  echo '{"error": "jq is required but not installed"}' >&2
  exit 1
fi

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // ""')
SOURCE="$(hostname)-${SESSION_ID:0:8}"

echo "$INPUT" | jq --arg src "$SOURCE" '{
  hookSpecificOutput: {
    hookEventName: "BeforeTool",
    permissionDecision: "allow",
    updatedInput: (.tool_input | .source = $src)
  }
}'
