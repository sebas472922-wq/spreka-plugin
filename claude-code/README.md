# Spreka Plugin for Claude Code

> **Status: 検証済**

## インストール手順

### 1. Sprekaサーバーを起動

> **実行場所: ターミナル**（Claude Codeの外）

```bash
spreka server
```

> **重要**: Sprekaサーバーは **Claude Codeを起動する前に** 起動してください。
> Claude CodeはMCPサーバーへの接続を起動時に1回だけ試みます。
> サーバーが停止している場合、プラグインは自動的にスキップされ、通常の操作に影響はありません。

### 2. マーケットプレイスを追加

> **実行場所: Claude Codeのプロンプト**

```
/plugin marketplace add sebas472922-wq/spreka-plugin
```

### 3. プラグインをインストール

> **実行場所: Claude Codeのプロンプト**

```
/plugin install spreka@spreka-plugins
```

「Discover」タブから `spreka` を選択してインストールしてください。

### 4. プラグインを有効化

> **実行場所: Claude Codeのプロンプト**

```
/reload-plugins
```

以下のような出力が表示されれば成功です（数値はバージョンにより異なります）：
```
Reloaded: N plugins · N skills · N agents · N hooks · 1 plugin MCP server · ...
```

### 5. 接続先の変更（LAN / リモートの場合のみ）

デフォルトは `http://localhost:9100` です。ローカルやSSH経由の場合は設定不要で、手順6へ進んでください。

| 接続パターン | 設定 |
|-------------|------|
| ローカル | 設定不要 → 手順6へ |
| SSH経由 | `ssh -R 9100:localhost:9100 remote-server` でポートフォワーディング。設定不要 → 手順6へ |
| LAN / リモート | 下記コマンドで変更 |

> **実行場所: ターミナル**（Claude Codeの外で実行してください）

```bash
claude mcp add --transport http -s user spreka http://<サーバーのアドレス>:9100/mcp
```

変更後はClaude Codeを再起動してください（再起動時に設定が反映されます）。

### 6. 動作確認

Claude Codeのプロンプトで何か作業を依頼すると、Skillの指示に従ってClaude自身がspeakを呼び、音声が再生されます。

## 提供するMCPツール

| ツール | 説明 |
|-------|------|
| `speak` | テキストを音声で読み上げる |
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

## プラグインの更新

> **実行場所: Claude Codeのプロンプト**

```
/plugin marketplace update spreka-plugins
/reload-plugins
```

自動更新を有効にする場合:

> `/plugin` → 「Marketplaces」タブ → `spreka-plugins` を選択 → 「Enable auto-update」

サードパーティマーケットプレイスはデフォルトで自動更新が無効です。有効にすると起動時に自動更新されます。

## アンインストール

```
/plugin uninstall spreka@spreka-plugins
```
