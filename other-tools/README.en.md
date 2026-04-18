# Spreka MCP Connection — Other Tools

> **Status: Unverified** — Config examples are provided but have not been tested yet. They may contain errors.

These tools don't have plugin/hook systems, but can connect to Spreka as an MCP server.
The speak/status tools will be available.

## Setup

1. Add the MCP connection to your tool's settings (see config examples below)
2. Connects to the cloud server (`https://spreka.se-es.net`) by default

## Config Examples

| Tool | Config File | Copy To |
|------|-------------|---------|
| Cursor | [cursor.json](cursor.json) | `.cursor/mcp.json` |
| Windsurf | [windsurf.json](windsurf.json) | `~/.codeium/windsurf/mcp_config.json` |
| Cline | [cline.json](cline.json) | VS Code MCP settings |
| Roo Code | [roo-code.json](roo-code.json) | VS Code MCP settings |
| Continue.dev | [continue.yaml](continue.yaml) | `.continue/mcpServers/spreka.yaml` |

## Server Address

Update the URL (default: `https://spreka.se-es.net/mcp`) in each config file. For local server, use `http://localhost:9100/mcp`.

## Notes

- No hook support — source auto-injection is not available
- No Skill support — tools must be called manually
- Core TTS features (speak/status) work with all tools
