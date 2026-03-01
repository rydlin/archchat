# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com),
and this project adheres to [Semantic Versioning](https://semver.org).

## [Unreleased]

### Changed

- Clipboard detection now prefers available tools over display environment (Wayland `wl-paste`, then X11 `xclip`/`xsel`, macOS `pbpaste`)
- Hashing now supports `sha256sum` or `shasum -a 256` for broader platform compatibility
- Bash requirement lowered to 3.2 by removing case-conversion dependency

## [1.1.0] - 2026-03-01

### Added

- X11 clipboard support via `xclip`
- macOS clipboard support via `pbpaste`
- Auto-detection of display server (macOS, Wayland, X11) for clipboard access

### Changed

- `archchat`: clipboard command is now auto-detected instead of hardcoded `wl-paste`
- `install.sh`: dependency check now validates the clipboard tool for the current platform
- Updated README, issue template, and PR template to reflect cross-platform support

## [1.0.0] - 2026-03-01

### Added

- Main `archchat` script for archiving AI chats from clipboard into Obsidian
- Wayland clipboard integration via `wl-paste`
- Automatic AI agent detection from URL domain (Claude, Grok, ChatGPT, Gemini, DeepSeek, Perplexity)
- Fallback agent extraction for unknown domains
- Case-insensitive subfolder resolution against existing directories
- YAML frontmatter generation (date, time, agent, topic, project, source URL, tags, status)
- SHA-256 URL hashing for deterministic filenames (same conversation overwrites itself)
- Configurable vault path via `OBSIDIAN_AICHATS` environment variable
- Installer script (`install.sh`) with dependency checks
- Uninstaller script (`uninstall.sh`)
- YourAIScroll browser extension setup guide
- Carriage return stripping for cross-platform clipboard content
