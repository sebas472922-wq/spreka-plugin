# Spreka Plugin for Claude Code

> **Status: Verified**

## Installation

### 1. Start Spreka Server

```bash
spreka server
```

> **Important**: Start the Spreka server **before** launching Claude Code.
> Claude Code connects to MCP servers only at startup.
> If the server is not running, the plugin is silently skipped with no impact on normal operations.

### 2. Add Marketplace

In the Claude Code prompt:

```
/plugin marketplace add sebas472922-wq/spreka-plugin
```

### 3. Install Plugin

```
/plugin install spreka@spreka-plugins
```

Select `spreka` from the "Discover" tab to install.

### 4. Activate Plugin

```
/reload-plugins
```

You should see:
```
Reloaded: N plugins · 0 skills · N agents · 3 hooks · 1 plugin MCP server · ...
```

### 5. Change Server Address (LAN / Remote only)

Default is `http://localhost:9100`. No configuration needed for local or SSH setups.

| Pattern | Setup |
|---------|-------|
| Local | No configuration needed |
| SSH | Port forwarding: `ssh -R 9100:localhost:9100 remote-server`. No configuration needed |
| LAN / Remote | Update with the command below |

```bash
claude mcp add --transport http -s user spreka http://<server-address>:9100/mcp
```

Restart Claude Code after changing.

### 6. Verify

Ask Claude Code to perform a task. Claude will call speak according to the Skill instructions, and you should hear audio.

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

## Auto-registered Hooks

| Event | Action |
|-------|--------|
| SessionStart | Health check + source registration |
| PreToolUse (speak) | Auto-inject source |
| Stop | Beep + last message read-aloud (via MCP JSON-RPC) |

## Uninstall

```
/plugin uninstall spreka@spreka-plugins
```
