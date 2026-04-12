# Spreka for Codex CLI

## Installation

```bash
# Install as plugin (if plugin feature is enabled)
/plugins install spreka

# Or manual setup:
# 1. Enable hooks in config.toml
# [features]
# codex_hooks = true
#
# 2. Configure MCP in config.toml
# [mcp_servers.spreka]
# url = "http://localhost:9100/mcp"
#
# 3. Copy hooks.json to ~/.codex/hooks.json
#    Note: Update paths in hooks.json to match your actual script locations
# 4. Copy skills/ to ~/.codex/skills/
```

## Prerequisites

Start the Spreka server **before** launching Codex CLI.

```bash
spreka server
```

## MCP Tools

| Tool | Description |
|------|-------------|
| `speak` | Speak text aloud |
| `set_voice` | Change voice, speed, pitch, etc. |
| `status` | Return server status |

## Skill Presets

| Skill | Description |
|-------|-------------|
| `spreka-operator-ja` | Japanese operator-style reports |
| `spreka-operator-en` | English operator-style reports |

## Server Address

Update the URL in `codex/.mcp.json`. Hook scripts automatically read from this file.

## Auto-registered Hooks

| Event | Action |
|-------|--------|
| SessionStart | Register source with server |
| PreToolUse (speak) | Auto-inject source |
