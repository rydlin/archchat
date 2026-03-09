#!/usr/bin/env bash
# uninstall.sh - Remove archchat from a user bin directory
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

DEST="${1:-$(pick_install_dir)}/archchat"

if [[ -f "$DEST" ]]; then
    rm "$DEST"
    echo "Removed ${DEST}"
else
    echo "archchat is not installed at ${DEST}"
fi
