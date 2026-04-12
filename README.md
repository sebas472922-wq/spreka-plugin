# Spreka Plugin

AIエージェントの出力をリアルタイムで音声読み上げするプラグイン集。
ターミナルをオペレーションセンターに。

Real-time text-to-speech plugin for AI coding agents.

## 対応エージェント / Supported Agents

| Agent | Plugin/Extension | Hooks | MCP | Setup |
|-------|:---:|:---:|:---:|-------|
| Claude Code | ✅ | ✅ | ✅ | [日本語](claude-code/README.md) / [English](claude-code/README.en.md) |
| Codex CLI | ✅ | ✅ | ✅ | [日本語](codex/README.md) / [English](codex/README.en.md) |
| Gemini CLI | ✅ | ✅ | ✅ | [日本語](gemini/README.md) / [English](gemini/README.en.md) |
| Cursor / Windsurf / Cline / Roo Code / Continue.dev | - | - | ✅ | [日本語](other-tools/README.md) / [English](other-tools/README.en.md) |

## 必要な環境 / Prerequisites

- Sprekaサーバーがローカルで起動していること
- Download: [GitHub Releases](https://github.com/sebas472922-wq/spreka/releases)

```bash
spreka server
```

## 機能レベル / Feature Levels

| レベル | 説明 | 対応エージェント |
|-------|------|----------------|
| **Full** | Plugin + Hooks + Skills + MCP | Claude Code, Codex, Gemini |
| **MCP only** | speakツールの手動呼び出し | Cursor, Windsurf, Cline, Roo Code, Continue.dev |

## 接続先の変更 / Server Address

デフォルトは `http://localhost:9100` です。変更方法は各エージェントのドキュメントを参照してください。

Default: `http://localhost:9100`. See each agent's docs for details.

## Powered by VOICEVOX Nemo

