#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_FILE="$SCRIPT_DIR/keyboard.json"

# Auto-detect Windows username from USERPROFILE or current directory owner
WIN_USER=$(powershell.exe -c 'echo $env:USERNAME' 2>/dev/null | tr -d '\r' || echo "$USER")
TARGET_DIR="/mnt/c/Users/$WIN_USER/AppData/Local/Microsoft/PowerToys/Keyboard Manager"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: keyboard.json not found at $SOURCE_FILE"
    exit 1
fi

mkdir -p "$TARGET_DIR"

cp "$SOURCE_FILE" "$TARGET_DIR/default.json"

echo "PowerToys keyboard configuration copied successfully to:"
echo "$TARGET_DIR/default.json"
