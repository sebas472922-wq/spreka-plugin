# Spreka Plugin

AIエージェントの出力をリアルタイムで音声読み上げするプラグイン集。
ターミナルをオペレーションセンターに。

Real-time text-to-speech plugin for AI coding agents.

## 対応エージェント / Supported Agents

| Agent | Plugin/Extension | Hooks | MCP | Status | Setup |
|-------|:---:|:---:|:---:|:---:|-------|
| Claude Code | ✅ | ✅ | ✅ | **検証済** | [日本語](claude-code/README.md) / [English](claude-code/README.en.md) |
| Codex CLI | ✅ | ✅ | ✅ | 未検証 | [日本語](codex/README.md) / [English](codex/README.en.md) |
| Gemini CLI | ✅ | ✅ | ✅ | 未検証 | [日本語](gemini/README.md) / [English](gemini/README.en.md) |
| Cursor / Windsurf / Cline / Roo Code / Continue.dev | - | - | ✅ | 未検証 | [日本語](other-tools/README.md) / [English](other-tools/README.en.md) |

> **注意**: 「未検証」のエージェントは設定ファイルを用意していますが、実際のインストール・動作確認はまだ行っていません。設定に誤りがある可能性があります。検証が完了したものから順次「検証済」に更新します。

## クイックスタート / Quick Start

プラグインをインストールするだけで、クラウド上のSprekaサーバー（`https://spreka.se-es.net`）に接続されます。ローカルサーバーの起動は不要です。

Just install the plugin — it connects to the Spreka cloud server (`https://spreka.se-es.net`) by default. No local server needed.

## 機能レベル / Feature Levels

| レベル | 説明 | 対応エージェント |
|-------|------|----------------|
| **Full** | Plugin + Hooks + Skills + MCP | Claude Code, Codex, Gemini |
| **MCP only** | speakツールの手動呼び出し | Cursor, Windsurf, Cline, Roo Code, Continue.dev |

## 接続先の変更 / Server Address

デフォルトは `https://spreka.se-es.net` です。変更方法は各エージェントのドキュメントを参照してください。

Default: `https://spreka.se-es.net`. See each agent's docs for details.

### ローカルサーバーを使う場合 / Using a Local Server

上級者向け: ローカルでSprekaサーバーを起動して使うこともできます。

For advanced users: you can run a local Spreka server instead.

```bash
spreka server
# Then change MCP URL to http://localhost:9100/mcp
```

Download: [GitHub Releases](https://github.com/sebas472922-wq/spreka/releases)

## Powered by VOICEVOX Nemo
