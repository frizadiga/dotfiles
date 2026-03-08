#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect Windows username from /mnt/c/Users (no powershell.exe needed)
WIN_USER=$(ls /mnt/c/Users | grep -v -E '^(Public|Default|Default User|All Users|desktop\.ini)$' | head -1)

# Locate Cmder installation
find_cmder() {
    local candidates=(
        "/mnt/c/Users/$WIN_USER/scoop/apps/cmder-full/current"
        "/mnt/c/Users/$WIN_USER/cmder"
        "/mnt/c/tools/cmder"
        "/mnt/c/cmder"
    )
    for dir in "${candidates[@]}"; do
        if [ -d "$dir/config" ]; then
            echo "$dir"
            return 0
        fi
    done
    echo "Error: Cmder not found in any of: ${candidates[*]}" >&2
    return 1
}

CMDER_DIR=$(find_cmder) || {
    echo "Error: Cmder installation not found"
    exit 1
}

echo "Detected Cmder directory: $CMDER_DIR"

CONFIG_DIR="$CMDER_DIR/config"
BACKUP_DIR="${CMDER_DIR}_config_backup_$(date +%Y%m%d_%H%M%S)"

# Backup existing config
if [ -d "$CONFIG_DIR" ]; then
    echo "Backing up existing config to: $BACKUP_DIR"
    cp -r "$CONFIG_DIR" "$BACKUP_DIR"
fi

SRC_DIR="$SCRIPT_DIR/config"

# Files to restore (src in dotfiles → dst in Cmder)
declare -A FILES=(
    ["$SRC_DIR/user_profile.cmd"]="$CONFIG_DIR/user_profile.cmd"
    ["$SRC_DIR/user_aliases.cmd"]="$CONFIG_DIR/user_aliases.cmd"
    ["$SRC_DIR/user-ConEmu.xml"]="$CONFIG_DIR/user-ConEmu.xml"
)

declare -A DIRS=(
    ["$SRC_DIR/profile.d"]="$CONFIG_DIR/profile.d"
)

INSTALLED=()

# Copy files, replacing placeholder with real Windows path
WIN_HOME="C:\\Users\\$WIN_USER"
for src in "${!FILES[@]}"; do
    dst="${FILES[$src]}"
    if [ ! -f "$src" ]; then
        continue
    fi
    mkdir -p "$(dirname "$dst")"
    sed "s|%USERPROFILE%|$WIN_HOME|g" "$src" > "$dst"
    INSTALLED+=("$dst")
done

# Copy optional directories
for src in "${!DIRS[@]}"; do
    dst="${DIRS[$src]}"
    if [ ! -d "$src" ]; then
        continue
    fi
    mkdir -p "$dst"
    cp -r "$src/." "$dst/"
    # Replace placeholder in all copied files
    find "$dst" -type f | while read -r f; do
        sed -i "s|%USERPROFILE%|$WIN_HOME|g" "$f"
    done
    INSTALLED+=("$dst")
done

echo ""
echo "Installed files:"
for f in "${INSTALLED[@]}"; do
    echo "  $f"
done
