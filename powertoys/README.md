# PowerToys Keyboard Manager Configuration

This directory contains PowerToys Keyboard Manager configuration and management scripts.

## Configuration (`keyboard.json`)

### Global Shortcut Remaps
- **Alt + W** → **Alt + F4** (Close window)
- **Copilot key** (`Win + Shift + 134`) → **Left Ctrl** (remapped via shortcut approach)

### App-Specific Shortcuts

#### Google Chrome (`chrome.exe`)
- **Ctrl + P** → **Ctrl + T** (New tab instead of print)

#### Microsoft Edge (`msedge.exe`)
- **Ctrl + P** → **Ctrl + T** (New tab instead of print)

## Scripts

- `install.sh` - Install or update PowerToys configuration
- `restart.sh` - Restart PowerToys Keyboard Manager
- `dump.sh` - Export current configuration

## Key Codes Reference

Common key codes used in the configuration:
- 17 = Ctrl
- 18 = Alt
- 80 = P
- 84 = T
- 87 = W
- 91 = Win (Left Windows)
- 115 = F4
- 160 = Left Shift
- 162 = Left Ctrl
