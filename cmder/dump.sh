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

OUT_DIR="$SCRIPT_DIR/config"
mkdir -p "$OUT_DIR"

# Required files
declare -A REQUIRED_FILES=(
    ["$CMDER_DIR/config/user_profile.cmd"]="$OUT_DIR/user_profile.cmd"
    ["$CMDER_DIR/config/user_aliases.cmd"]="$OUT_DIR/user_aliases.cmd"
    ["$CMDER_DIR/config/user-ConEmu.xml"]="$OUT_DIR/user-ConEmu.xml"
)

# Optional directories
declare -A OPTIONAL_DIRS=(
    ["$CMDER_DIR/config/profile.d"]="$OUT_DIR/profile.d"
)

EXPORTED=()

# Copy required files
for src in "${!REQUIRED_FILES[@]}"; do
    dst="${REQUIRED_FILES[$src]}"
    if [ ! -f "$src" ]; then
        echo "Warning: required file not found: $src"
        continue
    fi
    cp "$src" "$dst"
    EXPORTED+=("$dst")
done

# Copy optional directories
for src in "${!OPTIONAL_DIRS[@]}"; do
    dst="${OPTIONAL_DIRS[$src]}"
    if [ ! -d "$src" ]; then
        continue
    fi
    mkdir -p "$dst"
    cp -r "$src/." "$dst/"
    EXPORTED+=("$dst")
done

# Normalize Windows paths in exported text files
WIN_PATH_PATTERN="C:\\\\Users\\\\$WIN_USER"
for f in "${EXPORTED[@]}"; do
    if [ -f "$f" ]; then
        sed -i "s|C:\\\\Users\\\\$WIN_USER|%USERPROFILE%|g" "$f"
    elif [ -d "$f" ]; then
        find "$f" -type f | while read -r tf; do
            sed -i "s|C:\\\\Users\\\\$WIN_USER|%USERPROFILE%|g" "$tf"
        done
    fi
done

echo ""
echo "Exported files:"
for f in "${EXPORTED[@]}"; do
    echo "  $f"
done

echo ""
echo "Resulting tree:"
find "$SCRIPT_DIR/config" -not -name "*.sh" -not -name "Makefile" -not -name "specs.md" | sort | sed "s|$SCRIPT_DIR/||" | grep -v "^$"
