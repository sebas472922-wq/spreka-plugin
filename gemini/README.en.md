# Spreka for Gemini CLI

> **Status: Unverified** — Installation and operation have not been tested yet. Configuration may contain errors.

## Installation

### Option A: Install as Extension

> **Run in: Terminal**

```bash
gemini extensions install https://github.com/sebas472922-wq/spreka-plugin
```

### Option B: Manual Setup

> **Run in: Terminal / text editor** (outside Gemini CLI)

1. Add MCP server to `~/.gemini/settings.json`:
   ```json
   {
     "mcpServers": {
       "spreka": {
         "httpUrl": "https://spreka.se-es.net/mcp"
       }
     }
   }
   ```

2. Copy `skills/` to `~/.gemini/skills/`
3. Add hooks to `settings.json` (see "Hook Configuration" below)

## Prerequisites

Connects to the cloud server (`https://spreka.se-es.net`) by default. No local server needed.

For advanced users running a local server:

```bash
spreka server
# Change httpUrl in gemini-extension.json to http://localhost:9100/mcp
```

## MCP Tools

| Tool | Description |
|------|-------------|
| `speak` | Speak text aloud |
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
