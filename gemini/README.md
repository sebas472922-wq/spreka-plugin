# Spreka for Gemini CLI

> **Status: 未検証** — インストール・動作確認はまだ行っていません。設定に誤りがある可能性があります。

## インストール

```bash
# Extensionとしてインストール
gemini extensions install https://github.com/sebas472922-wq/spreka-plugin

# または手動セットアップ:
# 1. ~/.gemini/settings.json にMCPサーバーを追加
# {
#   "mcpServers": {
#     "spreka": {
#       "httpUrl": "http://localhost:9100/mcp"
#     }
#   }
# }
#
# 2. skills/ を ~/.gemini/skills/ にコピー
# 3. hooks を settings.json に追加（下記参照）
```

## 前提条件

Sprekaサーバーは **Gemini CLIを起動する前に** 起動してください。

```bash
spreka server
```

## 提供するMCPツール

| ツール | 説明 |
|-------|------|
| `speak` | テキストを音声で読み上げる |
| `set_voice` | 声質・速度等を変更する |
| `status` | サーバーの状態を返す |

> **注意**: Gemini CLIではツール名が `mcp_spreka_speak` です（アンダースコア1つ）。

## Skillプリセット

| Skill | 説明 |
|-------|------|
| `spreka-operator-ja` | 日本語オペレーター風の報告 |
| `spreka-operator-en` | 英語オペレーター風の報告 |

## 接続先の変更

`gemini-extension.json` 内の `httpUrl` を変更してください。

## Hook設定（手動セットアップ時）

`~/.gemini/settings.json` の `hooks` セクションに追加：

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
