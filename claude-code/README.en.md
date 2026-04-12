# Spreka Plugin for Claude Code

## Installation

```bash
# 1. Add marketplace
/plugin marketplace add sebas472922-wq/spreka-plugin

# 2. Install plugin
/plugin install spreka@sebas472922-wq-spreka-plugin
```

## Prerequisites

Start the Spreka server **before** launching Claude Code.
Claude Code connects to MCP servers only at startup.

```bash
spreka server
```

If the server is not running, the plugin is silently skipped with no impact on normal operations.

## MCP Tools

| Tool | Description |
|------|-------------|
| `speak` | Speak text aloud |
| `set_voice` | Change voice, speed, pitch, etc. |
| `status` | Return server status |

## Skill Presets

| Skill | Description |
|-------|-------------|
| `spreka-operator-ja` | Japanese operator-style reports (uses VOICEVOX Nemo) |
| `spreka-operator-en` | English operator-style reports |

## Server Address Configuration

Default: `http://localhost:9100`.

| Pattern | Setup |
|---------|-------|
| Local | No configuration needed |
| SSH | Port forwarding: `ssh -R 9100:localhost:9100 remote-server`. No configuration needed |
| LAN / Remote | Update with the command below |

```bash
claude mcp add --transport http -s user spreka http://192.168.x.x:9100/mcp
```

Hook scripts automatically read the URL from `.mcp.json`, so no additional configuration is needed.

## Auto-registered Hooks

| Event | Action |
|-------|--------|
| SessionStart | Health check + source registration |
| PreToolUse (speak) | Auto-inject source |
| Stop | Beep notification |
