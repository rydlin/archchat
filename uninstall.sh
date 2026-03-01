#!/usr/bin/env bash
# uninstall.sh - Remove archchat from ~/bin/
set -euo pipefail

DEST="$HOME/bin/archchat"

if [[ -f "$DEST" ]]; then
    rm "$DEST"
    echo "Removed ${DEST}"
else
    echo "archchat is not installed at ${DEST}"
fi
