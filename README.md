# archchat

Archive AI chat conversations from your clipboard into structured Markdown files.

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Platform: Linux/macOS](https://img.shields.io/badge/Platform-Linux%2FmacOS-brightgreen.svg)
![Shell: Bash](https://img.shields.io/badge/Shell-Bash-yellow.svg)

archchat is a command-line tool that takes an AI chat conversation from your clipboard and saves it as a structured Markdown file with YAML frontmatter. It auto-detects the AI platform and organizes files by project and topic. The output is plain Markdown written to any directory you choose — no specific tool is required to read it. That said, archchat is designed with [Obsidian](https://obsidian.md) in mind, where the frontmatter fields work as Properties and pair well with the Dataview plugin for querying and dashboarding your conversations.

## How It Works

1. **Export a chat** from any supported AI platform using the [YourAIScroll](docs/youraiscroll.md) browser extension. This copies the conversation to your clipboard in Markdown format with `Original URL: <url>` as the first line.
2. **Run `archchat`** in your terminal with a project/topic path.
3. **archchat reads the clipboard**, detects the AI agent from the URL domain, resolves the target directory (case-insensitively matching existing folders), generates a deterministic filename, and writes a structured Markdown file with YAML frontmatter into your target directory.

## Requirements

- Linux (Wayland or X11) or macOS
- `bash` >= 3.2
- A clipboard tool (auto-detected):
  - **Wayland**: `wl-clipboard` (provides `wl-paste`)
  - **X11**: `xclip` or `xsel`
  - **macOS**: `pbpaste` (included with macOS)
- A SHA-256 tool: `sha256sum` or `shasum -a 256`
- [YourAIScroll](docs/youraiscroll.md) browser extension (Chrome/Firefox/Edge)
- [Obsidian](https://obsidian.md) (recommended, but any directory works)

## Step 1: Install YourAIScroll

YourAIScroll is a browser extension that exports AI chat conversations to your clipboard in Markdown format. archchat depends on the `Original URL: <url>` line that YourAIScroll prepends to the clipboard content.

Install the extension, open any supported AI chat, click the YourAIScroll export button, and choose "Copy to Markdown" to copy the conversation to your clipboard.

See [docs/youraiscroll.md](docs/youraiscroll.md) for full installation and usage instructions.

## Step 2: Install archchat

```bash
git clone https://github.com/rydlin/archchat.git
cd archchat
bash install.sh
```

Then set the environment variable pointing to your target directory (e.g., an Obsidian vault):

```bash
# Add to ~/.bashrc or ~/.profile
export OBSIDIAN_AICHATS="$HOME/Documents/obsidian-vault/AIChats"
```

Adjust the path to match your directory. If not set, archchat defaults to `~/Obsidian/AI Chats`.

## Usage

```bash
archchat <project/topic>
```

Examples:

```bash
archchat vedikaos/http       # Project: vedikaos, Topic: http
archchat mx5/transmission    # Project: mx5, Topic: transmission
archchat homelab             # Project and topic: homelab
```

The argument is a subfolder path relative to your `OBSIDIAN_AICHATS` directory. The last path component becomes the **slug** (used in the filename and frontmatter topic). The first component becomes the **project**.

Directories are matched case-insensitively against existing folders. If a directory named `VedikaOS` already exists and you type `vedikaos`, archchat uses the existing `VedikaOS` directory. If no match is found, the directory is created as typed.

## Output File Format

archchat generates filenames in this format:

```
2026-03-01--grok--http--a12f4614.md
```

| Component | Description |
|-----------|-------------|
| `2026-03-01` | Date the chat was archived |
| `grok` | Detected AI agent |
| `http` | Slug (topic from the subfolder argument) |
| `a12f4614` | First 8 characters of the SHA-256 hash of the source URL |

The URL hash ensures that archiving the same conversation twice overwrites the previous file, while different conversations on the same day and topic get separate files.

Each file includes YAML frontmatter:

```yaml
---
date: 2026-03-01
time: 14:32
agent: grok
topic: "http"
project: vedikaos
source_url: "https://grok.com/c/..."
last_reviewed: 2026-03-01
tags: [ai-chat]
status: active
---
```

## Supported AI Platforms

| Platform | Domain | Agent value |
|----------|--------|-------------|
| Claude | claude.ai | `claude` |
| Grok | grok.com | `grok` |
| ChatGPT | chatgpt.com | `chatgpt` |
| Gemini | gemini.google.com | `gemini` |
| DeepSeek | deepseek.com | `deepseek` |
| Perplexity | perplexity.ai | `perplexity` |
| Other | any | extracted hostname |

For unrecognized domains, the agent value is extracted from the hostname (e.g., `https://www.example.com/chat` becomes `example`).

## Obsidian Integration

The YAML frontmatter fields are recognized by Obsidian as Properties and work with the [Dataview](https://github.com/blacksmithgu/obsidian-dataview) plugin for querying your archived chats.

**Project dashboard** — list all chats for a specific project:

```dataview
TABLE date, agent, topic, status
FROM "AIChats/vedikaos"
SORT date DESC
```

**Vault-wide query** — list all active chats across projects:

```dataview
TABLE date, agent, project, topic
FROM "AIChats"
WHERE status = "active"
SORT date DESC
```

## Uninstall

```bash
bash uninstall.sh
```

This removes `~/bin/archchat`. Your archived chat files are not affected.

## Contributing

Contributions are welcome. Fork the repository, create a feature branch, and open a pull request. See the [pull request template](.github/PULL_REQUEST_TEMPLATE.md) for the checklist.

The script intentionally has no dependencies beyond `bash`, a clipboard tool (`wl-paste`, `xclip`, `xsel`, or `pbpaste`), and a SHA-256 tool (`sha256sum` or `shasum`) — please do not introduce new external dependencies without discussion.

## License

[MIT](LICENSE)
