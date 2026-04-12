# Spreka MCP接続 — その他のツール

以下のツールはプラグイン/フック機能を持ちませんが、MCPサーバーとして接続できます。
speak/set_voice/statusツールが利用可能になります。

## セットアップ

1. Sprekaサーバーを起動: `spreka server`
2. 各ツールのMCP設定に接続先を追加（設定例は各ファイルを参照）

## 設定例

| ツール | 設定ファイル | コピー先 |
|-------|-------------|---------|
| Cursor | [cursor.json](cursor.json) | `.cursor/mcp.json` |
| Windsurf | [windsurf.json](windsurf.json) | `~/.codeium/windsurf/mcp_config.json` |
| Cline | [cline.json](cline.json) | VS Code設定のMCPセクション |
| Roo Code | [roo-code.json](roo-code.json) | VS Code設定のMCPセクション |
| Continue.dev | [continue.yaml](continue.yaml) | `.continue/mcpServers/spreka.yaml` |

## 接続先の変更

各設定ファイル内のURL（デフォルト: `http://localhost:9100/mcp`）を変更してください。

## 注意事項

- フック機能がないため、sourceの自動注入はありません
- Skillによる読み上げ制御もありません（ツールは手動で呼び出す形になります）
- 音声読み上げの基本機能（speak/set_voice/status）は全ツールで利用可能です
