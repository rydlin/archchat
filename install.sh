#!/usr/bin/env bash
# install.sh - Install archchat to a user bin directory
set -euo pipefail

pick_install_dir() {
    local candidates=("$HOME/bin" "$HOME/.local/bin")
    # Prefer existing dirs that are already in PATH
    for dir in "${candidates[@]}"; do
        if [[ -d "$dir" && ":$PATH:" == *":$dir:"* ]]; then
            echo "$dir"; return
        fi
    done
    # Fall back to any candidate in PATH (not yet created)
    for dir in "${candidates[@]}"; do
        if [[ ":$PATH:" == *":$dir:"* ]]; then
            echo "$dir"; return
        fi
    done
    # Fallback: use ~/.local/bin (XDG standard)
    echo "$HOME/.local/bin"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${SCRIPT_DIR}/archchat"
DEST_DIR="${1:-$(pick_install_dir)}"
DEST="${DEST_DIR}/archchat"

# ── Check bash version ───────────────────────────────────────────────────────
if [[ "${BASH_VERSINFO[0]}" -lt 3 ]] || \
   { [[ "${BASH_VERSINFO[0]}" -eq 3 ]] && [[ "${BASH_VERSINFO[1]}" -lt 2 ]]; }; then
    echo "Error: bash >= 3.2 is required (found ${BASH_VERSION})."
    exit 1
fi

# ── Check for clipboard tool ─────────────────────────────────────────────────
if [[ "$(uname -s)" == "Darwin" ]]; then
    if ! command -v pbpaste &>/dev/null; then
        echo "Error: pbpaste not found (should be included with macOS)."
        exit 1
    fi
else
    if command -v wl-paste &>/dev/null; then
        :
    elif command -v xclip &>/dev/null; then
        :
    elif command -v xsel &>/dev/null; then
        :
    else
        echo "Error: No clipboard tool found."
        echo "Install a clipboard tool for your platform:"
        echo "  Wayland: wl-clipboard (wl-paste)"
        echo "  X11:     xclip or xsel"
        exit 1
    fi
fi

# ── Check for sha256sum or shasum ────────────────────────────────────────────
if ! command -v sha256sum &>/dev/null && ! command -v shasum &>/dev/null; then
    echo "Error: sha256sum or shasum not found."
    echo "Install coreutils (Linux) or ensure shasum is available (macOS)."
    exit 1
fi

# ── Check source script exists ───────────────────────────────────────────────
if [[ ! -f "$SOURCE" ]]; then
    echo "Error: archchat script not found at ${SOURCE}"
    exit 1
fi

# ── Create dest dir if needed ────────────────────────────────────────────────
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
    echo "  export PATH=\"${DEST_DIR}:\$PATH\""
    echo ""
    echo "  # For zsh (~/.zshrc):"
    echo "  export PATH=\"${DEST_DIR}:\$PATH\""
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
