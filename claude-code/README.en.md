# Spreka Plugin for Claude Code

> **Status: Verified**

## Installation

### 1. Add Marketplace

> **Run in: Claude Code prompt**

```
/plugin marketplace add sebas472922-wq/spreka-plugin
```

### 2. Install Plugin

> **Run in: Claude Code prompt**

```
/plugin install spreka@spreka-plugins
```

Select `spreka` from the "Discover" tab to install.

### 3. Activate Plugin

> **Run in: Claude Code prompt**

```
/reload-plugins
```

You should see output like this (numbers may vary by version):
```
Reloaded: N plugins · N skills · N agents · N hooks · 1 plugin MCP server · ...
```

### 4. Verify

Ask Claude Code to perform a task. Claude will call speak according to the Skill instructions, and you should hear audio.

To hear the audio, open https://spreka.se-es.net in your browser and log in.

## Change Server Address (Advanced)

The default is the cloud server (`https://spreka.se-es.net`). Only change this if you want to use a local server.

| Pattern | Setup |
|---------|-------|
| Cloud (default) | No configuration needed |
| Local server | Update with the command below |
| SSH | Port forwarding: `ssh -R 9100:localhost:9100 remote-server`, then update with the command below |

> **Run in: Terminal** (outside Claude Code)

```bash
claude mcp add --transport http -s user spreka http://localhost:9100/mcp
```

Restart Claude Code after changing (the new settings take effect on restart).

## MCP Tools

| Tool | Description |
|------|-------------|
| `speak` | Speak text aloud |
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

## Updating the Plugin

> **Run in: Claude Code prompt**

```
/plugin marketplace update spreka-plugins
/reload-plugins
```

To enable auto-update:

> `/plugin` → "Marketplaces" tab → select `spreka-plugins` → "Enable auto-update"

Third-party marketplaces have auto-update disabled by default. Once enabled, plugins are updated automatically at startup.

## Uninstall

```
/plugin uninstall spreka@spreka-plugins
```
