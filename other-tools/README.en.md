# Spreka MCP Connection — Other Tools

These tools don't have plugin/hook systems, but can connect to Spreka as an MCP server.
The speak/set_voice/status tools will be available.

## Setup

1. Start Spreka server: `spreka server`
2. Add the MCP connection to your tool's settings (see config examples below)

## Config Examples

| Tool | Config File | Copy To |
|------|-------------|---------|
| Cursor | [cursor.json](cursor.json) | `.cursor/mcp.json` |
| Windsurf | [windsurf.json](windsurf.json) | `~/.codeium/windsurf/mcp_config.json` |
| Cline | [cline.json](cline.json) | VS Code MCP settings |
| Roo Code | [roo-code.json](roo-code.json) | VS Code MCP settings |
| Continue.dev | [continue.yaml](continue.yaml) | `.continue/mcpServers/spreka.yaml` |

## Server Address

Update the URL (default: `http://localhost:9100/mcp`) in each config file.

## Notes

- No hook support — source auto-injection is not available
- No Skill support — tools must be called manually
- Core TTS features (speak/set_voice/status) work with all tools
