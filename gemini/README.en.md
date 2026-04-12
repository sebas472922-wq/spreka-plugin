# Spreka for Gemini CLI

> **Status: Unverified** — Installation and operation have not been tested yet. Configuration may contain errors.

## Installation

```bash
# Install as extension
gemini extensions install https://github.com/sebas472922-wq/spreka-plugin

# Or manual setup:
# 1. Add MCP server to ~/.gemini/settings.json
# {
#   "mcpServers": {
#     "spreka": {
#       "httpUrl": "http://localhost:9100/mcp"
#     }
#   }
# }
#
# 2. Copy skills/ to ~/.gemini/skills/
# 3. Add hooks to settings.json (see below)
```

## Prerequisites

Start the Spreka server **before** launching Gemini CLI.

```bash
spreka server
```

## MCP Tools

| Tool | Description |
|------|-------------|
| `speak` | Speak text aloud |
| `set_voice` | Change voice, speed, pitch, etc. |
| `status` | Return server status |

> **Note**: Tool names in Gemini CLI use single underscore: `mcp_spreka_speak`.

## Skill Presets

| Skill | Description |
|-------|-------------|
| `spreka-operator-ja` | Japanese operator-style reports |
| `spreka-operator-en` | English operator-style reports |

## Server Address

Update `httpUrl` in `gemini-extension.json`.

## Hook Configuration (Manual Setup)

Add to `~/.gemini/settings.json` hooks section:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [{
          "type": "command",
          "command": "bash ~/.gemini/extensions/spreka-plugin/gemini/hooks/session-start.sh"
        }]
      }
    ],
    "BeforeTool": [
      {
        "matcher": "mcp_spreka_speak",
        "hooks": [{
          "type": "command",
          "command": "bash ~/.gemini/extensions/spreka-plugin/gemini/hooks/before-tool.sh"
        }]
      }
    ]
  }
}
```
