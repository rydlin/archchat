# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com),
and this project adheres to [Semantic Versioning](https://semver.org).

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
