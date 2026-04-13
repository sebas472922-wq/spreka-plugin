# Spreka for Codex CLI

> **Status: 未検証** — インストール・動作確認はまだ行っていません。設定に誤りがある可能性があります。

## インストール

### 方法A: プラグインとしてインストール

> **実行場所: Codex CLIのプロンプト**（プラグイン機能が有効な場合）

```
/plugins install spreka
```

### 方法B: 手動セットアップ

> **実行場所: ターミナル / テキストエディタ**（Codex CLIの外）

1. `~/.codex/config.toml` でフック機能を有効化:
   ```toml
   [features]
   codex_hooks = true
   ```

2. 同じファイルにMCP接続を設定:
   ```toml
   [mcp_servers.spreka]
   url = "http://localhost:9100/mcp"
   ```

3. `hooks.json` を `~/.codex/hooks.json` にコピー（パスを実際の配置場所に書き換えてください）
4. `skills/` を `~/.codex/skills/` にコピー

## 前提条件

> **実行場所: ターミナル**（Codex CLIの外）

Sprekaサーバーは **Codex CLIを起動する前に** 起動してください。

```bash
spreka server
```

## 提供するMCPツール

| ツール | 説明 |
|-------|------|
| `speak` | テキストを音声で読み上げる |
| `status` | サーバーの状態を返す |

## Skillプリセット

| Skill | 説明 |
|-------|------|
| `spreka-operator-ja` | 日本語オペレーター風の報告 |
| `spreka-operator-en` | 英語オペレーター風の報告 |

## 接続先の変更

`codex/.mcp.json` のURLを変更してください。Hookスクリプトはこのファイルから自動読み取りします。

## 自動登録されるHook

| イベント | 動作 |
|---------|------|
| SessionStart | サーバーにsource登録 |
| PreToolUse（speak時） | sourceを自動注入 |
