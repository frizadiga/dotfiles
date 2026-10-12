#!/bin/bash
#
# Deploy window-switch.ahk to Windows and register a Startup shortcut.
#
# Source of truth: window-switch.ahk in this directory (dotfiles repo).
# Deployed artifact: %LOCALAPPDATA%\ahk\window-switch.ahk (a real
# file copy, never a WSL symlink, so it works at login before WSL starts).
#
# Idempotent and safe to re-run. Skips gracefully when not running under WSL.
#
# Usage:
#   ./install.sh
#
# Env overrides:
#   AHK_EXE  explicit path to the AutoHotkey v2 executable (Windows path,
#            e.g. "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe").

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_FILE="$SCRIPT_DIR/window-switch.ahk"

if [ ! -f "$SRC_FILE" ]; then
    echo "Error: window-switch.ahk not found at $SRC_FILE" >&2
    exit 1
fi

# Skip gracefully when not under WSL.
if [ ! -d "/mnt/c/Users" ]; then
    echo "Skipping autohotkey deploy: not running under WSL (/mnt/c/Users missing)."
    exit 0
fi

# Resolve the Windows user profile. Prefer cmd.exe via wslpath, fall back to
# guessing the user from /mnt/c/Users (no powershell.exe needed).
WIN_HOME=""
if command -v cmd.exe >/dev/null 2>&1 && command -v wslpath >/dev/null 2>&1; then
    WIN_HOME="$(wslpath "$(cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r')" 2>/dev/null || true)"
fi
if [ -z "$WIN_HOME" ] || [ ! -d "$WIN_HOME" ]; then
    WIN_USER=$(ls /mnt/c/Users 2>/dev/null | grep -v -E '^(Public|Default|Default User|All Users|desktop\.ini)$' | head -1)
    if [ -z "$WIN_USER" ]; then
        echo "Skipping autohotkey deploy: cannot determine Windows user." >&2
        exit 0
    fi
    WIN_HOME="/mnt/c/Users/$WIN_USER"
fi

# Locate powershell.exe (may not be on PATH when WSL interop PATH is off).
POWERSHELL_EXE=""
if command -v powershell.exe >/dev/null 2>&1; then
    POWERSHELL_EXE="powershell.exe"
elif [ -x "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" ]; then
    POWERSHELL_EXE="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
fi
if [ -z "$POWERSHELL_EXE" ]; then
    echo "Warning: powershell.exe not found; copied script but skipped Startup shortcut." >&2
fi

# 1. Copy the script (real copy, not a symlink).
TARGET_DIR="$WIN_HOME/AppData/Local/ahk"
TARGET_FILE="$TARGET_DIR/window-switch.ahk"
mkdir -p "$TARGET_DIR"
cp "$SRC_FILE" "$TARGET_FILE"
echo "Deployed autohotkey script to: $TARGET_FILE"

# 2. Create (or update) the Startup shortcut. Idempotent: overwrites the same
# .lnk every run with the deployed copy as target.
if [ -n "$POWERSHELL_EXE" ]; then
    # Resolve the AutoHotkey v2 executable (Windows-style path for the .lnk).
    # Env override wins; otherwise prefer per-user winget install, then
    # machine-wide install.
    if [ -n "${AHK_EXE:-}" ]; then
        AHK_WIN="$AHK_EXE"
    elif [ -x "$WIN_HOME/AppData/Local/Programs/AutoHotkey/v2/AutoHotkey64.exe" ]; then
        # Derive "C:\Users\<name>\..." from the /mnt/<drive>/... path.
        MNT_REST="${TARGET_FILE#/mnt/}"
        DRIVE_LETTER="$(echo "${MNT_REST%%/*}" | tr '[:lower:]' '[:upper:]')"
        REST="${MNT_REST#*/}"
        USER_PART="$(echo "$REST" | cut -d/ -f2)"
        AHK_WIN="$DRIVE_LETTER:\\Users\\$USER_PART\\AppData\\Local\\Programs\\AutoHotkey\\v2\\AutoHotkey64.exe"
    else
        AHK_WIN="C:\\Program Files\\AutoHotkey\\v2\\AutoHotkey64.exe"
    fi
    if [ ! -f "$(wslpath "$AHK_WIN" 2>/dev/null || echo /nonexistent)" ] && [ -z "${AHK_EXE:-}" ]; then
        # Fall back to the other candidate if the preferred one is missing.
        if [ -f "/mnt/c/Program Files/AutoHotkey/v2/AutoHotkey64.exe" ]; then
            AHK_WIN="C:\\Program Files\\AutoHotkey\\v2\\AutoHotkey64.exe"
        elif [ -f "$WIN_HOME/AppData/Local/Programs/AutoHotkey/v2/AutoHotkey64.exe" ]; then
            : # keep per-user path
        else
            echo "Warning: AutoHotkey v2 not found; Startup shortcut still created pointing at:" >&2
            echo "  $AHK_WIN" >&2
            echo "  Install it with: winget.exe install --id AutoHotkey.AutoHotkey -e" >&2
        fi
    fi

    # Windows-style path of the deployed script for the shortcut argument
    # (e.g. /mnt/c/Users/friza/AppData/Local/ahk/window-switch.ahk -> C:\Users\friza\...).
    MNT_REST="${TARGET_FILE#/mnt/}"
    DRIVE_LETTER="$(echo "${MNT_REST%%/*}" | tr '[:lower:]' '[:upper:]')"
    REST="${MNT_REST#*/}"
    SCRIPT_WIN="${DRIVE_LETTER}:\\${REST//\//\\}"

    "$POWERSHELL_EXE" -NoProfile -Command "
\$ahk = '$AHK_WIN'
\$script = '$SCRIPT_WIN'
\$lnk = Join-Path \$env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\window-switch.lnk'
\$s = (New-Object -ComObject WScript.Shell).CreateShortcut(\$lnk)
\$s.TargetPath = \$ahk
\$s.Arguments = '\`\"' + \$script + '\`\"'
\$s.WorkingDirectory = Split-Path \$script
\$s.Save()
Write-Output \"Startup shortcut: \$lnk\"
"
fi

echo ""
echo "Done. If AutoHotkey is already running, right-click the green \"H\" tray"
echo "icon and choose Reload/Exit, or re-run the script, so Alt+Shift+Tab takes effect."
