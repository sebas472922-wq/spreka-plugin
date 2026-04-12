# Spreka Plugin for Claude Code

## インストール

```bash
# 1. マーケットプレイスを追加
/plugin marketplace add sebas472922-wq/spreka-plugin

# 2. プラグインをインストール
/plugin install spreka@sebas472922-wq-spreka-plugin
```

## 前提条件

Sprekaサーバーは **Claude Codeを起動する前に** 起動してください。
Claude CodeはMCPサーバーへの接続を起動時に1回だけ試みます。

```bash
spreka server
```

サーバーが停止している場合、プラグインは自動的にスキップされ、通常の操作に影響はありません。

## 提供するMCPツール

| ツール | 説明 |
|-------|------|
| `speak` | テキストを音声で読み上げる |
| `set_voice` | 声質・速度等を変更する |
| `status` | サーバーの状態を返す |

## Skillプリセット

| Skill | 説明 |
|-------|------|
| `spreka-operator-ja` | 日本語オペレーター風の報告（VOICEVOX Nemo使用） |
| `spreka-operator-en` | 英語オペレーター風の報告 |

## 接続先の変更

デフォルトは `http://localhost:9100` です。

| 接続パターン | 設定 |
|-------------|------|
| ローカル | 設定不要 |
| SSH経由 | `ssh -R 9100:localhost:9100 remote-server` でポートフォワーディング。設定不要 |
| LAN / リモート | 下記コマンドで変更 |

```bash
claude mcp add --transport http -s user spreka http://192.168.x.x:9100/mcp
```

Hookスクリプトは `.mcp.json` からURLを自動読み取りするため、追加の設定は不要です。

## 自動登録されるHook

| イベント | 動作 |
|---------|------|
| SessionStart | サーバー生存確認 + source登録 |
| PreToolUse（speak時） | sourceを自動注入 |
| Stop | ビープ通知 |
