# AGENTS.md

This repository contains personal dotfiles managed with a custom symlinker.

## Structure
- Each top-level directory corresponds to a tool/config (e.g., `alacritty/`, `tmux/`, `nvim/` via `v/`, etc.)
- Platform-specific configs may live inside their respective directories (e.g., `alacritty/.alacritty.wsl.toml`)
- `wsl/` contains Windows/WSL2 specific configuration

## WSL
The `wsl/` directory contains:
- `.wslconfig` - WSL2 configuration for mirrored networking (fixes socket issues in some tools)
- `Makefile` - Use `make sync` or `make install` from `wsl/` to copy `.wslconfig` to Windows `%USERPROFILE%\.wslconfig`

From repo root: `make wsl-install` or `make wsl`

## Commit Convention
Use [Conventional Commits](https://www.conventionalcommits.org/):

```text
<type>(<scope>): <subject>
```

- **type**: `feat`, `fix`, `refactor`, `chore`, `docs`, `perf`, `test`, `style`, `build`, `ci`, `revert`
- **scope**: the affected config dir, lowercase (e.g., `tmux`, `autohotkey`, `opencode`, `v`). Omit when the change spans multiple areas or is repo-wide.
- **subject**: imperative mood, present tense, lowercase, no trailing period, 50 chars max. Body wraps at 72 chars.
- Reference the behavior change, not the file list.

Examples from this repo:

```text
feat(autohotkey): add Makefile with install and status targets
fix(tmux): force popup background to default
refactor(lazygit): migrate pagers to diffRenderers
chore(v): bump commit
chore: update v submodule to 012dcab
```

Mark breaking changes with `!` after the type/scope (`feat(tmux)!: ...`) or a `BREAKING CHANGE:` footer.

## Notes
- Symlinking is handled by external tooling (see README)
- Some files may be gitignored or tracked with assumptions (see `Makefile`)
