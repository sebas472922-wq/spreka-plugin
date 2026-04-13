# Spreka Plugin for Claude Code

> **Status: Verified**

## Installation

### 1. Start Spreka Server

> **Run in: Terminal** (outside Claude Code)

```bash
spreka server
```

> **Important**: Start the Spreka server **before** launching Claude Code.
> Claude Code connects to MCP servers only at startup.
> If the server is not running, the plugin is silently skipped with no impact on normal operations.

### 2. Add Marketplace

> **Run in: Claude Code prompt**

```
/plugin marketplace add sebas472922-wq/spreka-plugin
```

### 3. Install Plugin

> **Run in: Claude Code prompt**

```
/plugin install spreka@spreka-plugins
```

Select `spreka` from the "Discover" tab to install.

### 4. Activate Plugin

> **Run in: Claude Code prompt**

```
/reload-plugins
```

You should see output like this (numbers may vary by version):
```
Reloaded: N plugins · N skills · N agents · N hooks · 1 plugin MCP server · ...
```

### 5. Change Server Address (LAN / Remote only)

Default is `http://localhost:9100`. No configuration needed for local or SSH setups — skip to step 6.

| Pattern | Setup |
|---------|-------|
| Local | No configuration needed — skip to step 6 |
| SSH | Port forwarding: `ssh -R 9100:localhost:9100 remote-server`. No configuration needed — skip to step 6 |
| LAN / Remote | Update with the command below |

> **Run in: Terminal** (outside Claude Code)

```bash
claude mcp add --transport http -s user spreka http://<server-address>:9100/mcp
```

Restart Claude Code after changing (the new settings take effect on restart).

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
