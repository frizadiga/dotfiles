# AutoHotkey (Windows)

Alt+Shift+Tab opens PowerToys Run in Window Walker mode (`<` pre-typed),
so you can immediately type a window name and switch to it.

## Files

- `window-switch.ahk` — source of truth (AutoHotkey **v2** syntax).
  - `!+Tab` (Alt+Shift+Tab), `KeyWait`s release of Alt/Shift, then sends
    Alt+Space (PowerToys Run) and `<` (Window Walker keyword).
  - Plain Alt+Tab is unaffected.
- `install.sh` — idempotent, WSL-aware deploy: copies the script to
  `%LOCALAPPDATA%\ahk\window-switch.ahk` (real copy, never a WSL
  symlink) and creates a `window-switch.lnk` in the Windows Startup folder
  pointing at the deployed copy with the AutoHotkey v2 exe explicitly.
  Skips gracefully outside WSL.
- `spec.md` — original task spec.

## Install

Prerequisite (Windows side): AutoHotkey v2, e.g.

```powershell
winget.exe install --id AutoHotkey.AutoHotkey -e
```

Then from WSL:

```bash
./install.sh
```

Re-running is safe. If AutoHotkey is already running, right-click the green
"H" tray icon and Reload/Exit so the new script takes effect.

## Troubleshooting

- Nothing happens: check the green "H" tray icon (script running on Windows?).
- Language switcher pops up on Alt+Shift: disable Alt+Shift under
  *Settings, Time & language, Typing, Advanced keyboard settings,
  Input language hot keys*.
- `<` lands too early / in the wrong place: raise `Sleep 200` to `300`.
- PowerToys Run doesn't open: its activation shortcut isn't Alt+Space —
  update the `Send "!{Space}"` line (current setting verified as Alt+Space,
  Window Walker keyword `<`).
