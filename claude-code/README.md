# Spreka Plugin for Claude Code

> **Status: 検証済**

## インストール手順

### 1. Sprekaサーバーを起動

```bash
spreka server
```

> **重要**: Sprekaサーバーは **Claude Codeを起動する前に** 起動してください。
> Claude CodeはMCPサーバーへの接続を起動時に1回だけ試みます。
> サーバーが停止している場合、プラグインは自動的にスキップされ、通常の操作に影響はありません。

### 2. マーケットプレイスを追加

Claude Codeのプロンプトで以下を入力：

```
/plugin marketplace add sebas472922-wq/spreka-plugin
```

### 3. プラグインをインストール

```
/plugin install spreka@spreka-plugins
```

「Discover」タブから `spreka` を選択してインストールしてください。

### 4. プラグインを有効化

```
/reload-plugins
```

以下が表示されれば成功です：
```
Reloaded: N plugins · 0 skills · N agents · 3 hooks · 1 plugin MCP server · ...
```

### 5. 接続先の変更（LAN / リモートの場合のみ）

デフォルトは `http://localhost:9100` です。ローカルやSSH経由の場合は設定不要です。

| 接続パターン | 設定 |
|-------------|------|
| ローカル | 設定不要 |
| SSH経由 | `ssh -R 9100:localhost:9100 remote-server` でポートフォワーディング。設定不要 |
| LAN / リモート | 下記コマンドで変更 |

```bash
claude mcp add --transport http -s user spreka http://<サーバーのアドレス>:9100/mcp
```

変更後はClaude Codeを再起動してください。

### 6. 動作確認

Claude Codeのプロンプトで何か作業を依頼すると、Skillの指示に従ってClaude自身がspeakを呼び、音声が再生されます。

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

## 自動登録されるHook

| イベント | 動作 |
|---------|------|
| SessionStart | サーバー生存確認 + source登録 |
| PreToolUse（speak時） | sourceを自動注入 |
| Stop | ビープ音 + 最終メッセージ読み上げ（MCP JSON-RPC経由） |

## アンインストール

```
/plugin uninstall spreka@spreka-plugins
```
