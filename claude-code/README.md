# Spreka Plugin for Claude Code

> **Status: 検証済**

## インストール手順

### 1. マーケットプレイスを追加

> **実行場所: Claude Codeのプロンプト**

```
/plugin marketplace add sebas472922-wq/spreka-plugin
```

### 2. プラグインをインストール

> **実行場所: Claude Codeのプロンプト**

```
/plugin install spreka@spreka-plugins
```

「Discover」タブから `spreka` を選択してインストールしてください。

### 3. プラグインを有効化

> **実行場所: Claude Codeのプロンプト**

```
/reload-plugins
```

以下のような出力が表示されれば成功です（数値はバージョンにより異なります）：
```
Reloaded: N plugins · N skills · N agents · N hooks · 1 plugin MCP server · ...
```

### 4. 認証（初回のみ）

クラウドサーバーに接続する場合、初回のみ GitHub 認証が必要です。

1. プラグインインストール後、Claude Code が最初に `speak` を呼ぶとブラウザが開きます
2. GitHub で認可してください（「Authorize」ボタンを押すだけ）
3. 認証完了後、自動的に接続されます

> ローカルサーバー（`localhost`）を使う場合は認証不要です。

### 5. 動作確認

Claude Codeのプロンプトで何か作業を依頼すると、Skillの指示に従ってClaude自身がspeakを呼び、音声が再生されます。

音声を聴くには、ブラウザで https://spreka.se-es.net にアクセスしてログインしてください。

## 接続先の変更（上級者向け）

デフォルトはクラウドサーバー（`https://spreka.se-es.net`）です。ローカルサーバーを使う場合のみ変更が必要です。

| 接続パターン | 設定 |
|-------------|------|
| クラウド（デフォルト） | 設定不要 |
| ローカルサーバー | 下記コマンドで変更 |
| SSH経由 | `ssh -R 9100:localhost:9100 remote-server` でポートフォワーディング後、下記コマンドで変更 |

> **実行場所: ターミナル**（Claude Codeの外で実行してください）

```bash
claude mcp add --transport http -s user spreka http://localhost:9100/mcp
```

変更後はClaude Codeを再起動してください（再起動時に設定が反映されます）。

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

自動更新を有効にすると、Claude Code起動時に自動で最新版に更新されます（推奨）:

> **実行場所: Claude Codeのプロンプト**
>
> `/plugin` → 「Marketplaces」タブ → `spreka-plugins` を選択 → 「Enable auto-update」

手動で更新する場合:

> **実行場所: Claude Codeのプロンプト**

```
/plugin marketplace update spreka-plugins
/reload-plugins
```

サードパーティマーケットプレイスはデフォルトで自動更新が無効です。

## アンインストール

```
/plugin uninstall spreka@spreka-plugins
```
