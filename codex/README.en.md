# Spreka for Codex CLI

> **Status: Unverified** — Installation and operation have not been tested yet. Configuration may contain errors.

## Installation

### Option A: Install as Plugin

> **Run in: Codex CLI prompt** (if plugin feature is enabled)

```
/plugins install spreka
```

### Option B: Manual Setup

> **Run in: Terminal / text editor** (outside Codex CLI)

1. Enable hooks in `~/.codex/config.toml`:
   ```toml
   [features]
   codex_hooks = true
   ```

2. Configure MCP in the same file:
   ```toml
   [mcp_servers.spreka]
   url = "https://spreka.se-es.net/mcp"
   ```

3. Copy `hooks.json` to `~/.codex/hooks.json` (update paths to match your actual script locations)
4. Copy `skills/` to `~/.codex/skills/`

## Prerequisites

Connects to the cloud server (`https://spreka.se-es.net`) by default. No local server needed.

For advanced users running a local server:

```bash
spreka server
# Change URL in config.toml to http://localhost:9100/mcp
```

## MCP Tools

| Tool | Description |
|------|-------------|
| `speak` | Speak text aloud |
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
