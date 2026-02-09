#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_FILE="$SCRIPT_DIR/keyboard.json"

# Auto-detect Windows username from USERPROFILE or current directory owner
WIN_USER=$(powershell.exe -c 'echo $env:USERNAME' 2>/dev/null | tr -d '\r' || echo "$USER")
SOURCE_FILE="/mnt/c/Users/$WIN_USER/AppData/Local/Microsoft/PowerToys/Keyboard Manager/default.json"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: PowerToys configuration not found at $SOURCE_FILE"
    exit 1
fi

cp "$SOURCE_FILE" "$TARGET_FILE"

echo "PowerToys keyboard configuration dumped successfully to:"
echo "$TARGET_FILE"
