#!/usr/bin/env bash
# install.sh - Install archchat to ~/bin/
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${SCRIPT_DIR}/archchat"
DEST_DIR="$HOME/bin"
DEST="${DEST_DIR}/archchat"

# ── Check bash version ───────────────────────────────────────────────────────
if [[ "${BASH_VERSINFO[0]}" -lt 4 ]]; then
    echo "Error: bash >= 4.0 is required (found ${BASH_VERSION})."
    echo "archchat uses features like \${var,,} and BASH_REMATCH."
    exit 1
fi

# ── Check for wl-paste ───────────────────────────────────────────────────────
if ! command -v wl-paste &>/dev/null; then
    echo "Error: wl-paste not found (part of wl-clipboard)."
    echo "Install it for your distribution:"
    echo "  openSUSE:     sudo zypper install wl-clipboard"
    echo "  Debian/Ubuntu: sudo apt install wl-clipboard"
    echo "  Arch:          sudo pacman -S wl-clipboard"
    exit 1
fi

# ── Check for sha256sum ──────────────────────────────────────────────────────
if ! command -v sha256sum &>/dev/null; then
    echo "Error: sha256sum not found (part of coreutils)."
    exit 1
fi

# ── Check source script exists ───────────────────────────────────────────────
if [[ ! -f "$SOURCE" ]]; then
    echo "Error: archchat script not found at ${SOURCE}"
    exit 1
fi

# ── Create ~/bin if needed ───────────────────────────────────────────────────
if [[ ! -d "$DEST_DIR" ]]; then
    mkdir -p "$DEST_DIR"
    echo "Created ${DEST_DIR}/"
fi

# ── Copy and set permissions ─────────────────────────────────────────────────
cp "$SOURCE" "$DEST"
chmod +x "$DEST"

# ── Check PATH ───────────────────────────────────────────────────────────────
if [[ ":$PATH:" != *":$DEST_DIR:"* ]]; then
    echo ""
    echo "Warning: ${DEST_DIR} is not in your PATH."
    echo "Add it by appending this line to your shell profile:"
    echo ""
    echo "  # For bash (~/.bashrc):"
    echo "  export PATH=\"\$HOME/bin:\$PATH\""
    echo ""
    echo "  # For zsh (~/.zshrc):"
    echo "  export PATH=\"\$HOME/bin:\$PATH\""
    echo ""
    echo "Then reload your shell: source ~/.bashrc  (or source ~/.zshrc)"
fi

# ── Print env var instructions ───────────────────────────────────────────────
echo ""
echo "Set your Obsidian vault path by adding this to your shell profile:"
echo ""
echo "  export OBSIDIAN_AICHATS=\"\$HOME/Documents/obsidian-vault/AIChats\""
echo ""
echo "(Adjust the path to match your vault location.)"

# ── Confirm ──────────────────────────────────────────────────────────────────
echo ""
echo "archchat installed to ${DEST}"
