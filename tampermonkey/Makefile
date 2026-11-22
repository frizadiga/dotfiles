# Makefile for managing Tampermonkey scripts in this repo, one script at a time.
# Auto-discovers every *.user.js file in this directory.
#
# Usage:
#   make list                          list all tracked userscripts + their raw URLs
#   make deploy [FILE=name.user.js]    stamp @version on one script, then git push
#   make bump-version [FILE=...]       stamp @version on one script, no push
#   make open [FILE=name.user.js]      open one script's raw URL (first-time install)
#
# Without FILE=, an interactive shell picks the script with fzf (changed scripts
# marked "*" and listed first); a non-interactive run fails and asks for FILE=.
#
# Bulk (every changed script, modified or untracked; ALL=1 = every script):
#   make deploy-all | bump-version-all | open-all | list-changed
#
# @version is stamped with the current time (YYYY.MM.DD.HHMMSS) so Tampermonkey
# treats every push as a real update.

REPO     := frizadiga/dotfiles
BRANCH   := main
DIR      := tampermonkey
RAW_BASE := https://raw.githubusercontent.com/$(REPO)/$(BRANCH)/$(DIR)

SCRIPTS   := $(wildcard *.user.js)
TIMESTAMP := $(shell date +%Y.%m.%d.%H%M%S)

.PHONY: help list deploy bump-version open \
	list-changed bump-version-all deploy-all open-all _require-files

help:
	@sed -n '3,15p' $(firstword $(MAKEFILE_LIST)) | sed 's/^# \{0,1\}//'

list:
	@echo "Tracked userscripts:"
	@for f in $(SCRIPTS); do echo "  $$f  ->  $(RAW_BASE)/$$f"; done

# Sets $$f to FILE, or to an fzf pick when interactive. Changed scripts
# (modified or untracked) are marked "*" and listed first.
define resolve-file
f="$(FILE)"; \
if [ -z "$$f" ]; then \
	if [ -t 0 ] && command -v fzf >/dev/null 2>&1; then \
		changed="$$( { git diff --name-only --relative HEAD -- '*.user.js'; git ls-files --others --exclude-standard -- '*.user.js'; } | sort -u)"; \
		f="$$( { for s in $(SCRIPTS); do printf '%s\n' "$$changed" | grep -qxF "$$s" && echo "* $$s"; done; \
		         for s in $(SCRIPTS); do printf '%s\n' "$$changed" | grep -qxF "$$s" || echo "  $$s"; done; } \
		       | fzf --prompt='userscript> ' --height=40% --reverse --header='* = changed' | sed 's/^..//')"; \
		[ -n "$$f" ] || { echo "No script picked." >&2; exit 1; }; \
	else \
		echo "FILE is required when not interactive, e.g.: make $@ FILE=name.user.js" >&2; \
		echo "For every changed script: make $@-all" >&2; \
		exit 1; \
	fi; \
fi; \
[ -f "$$f" ] || { echo "Not found: $$f" >&2; exit 1; }
endef

# Tampermonkey compares @version; an unchanged version is silently ignored.
define stamp-file
sed -i.bak 's#^\(\/\/[[:space:]]*@version[[:space:]]*\).*#\1$(TIMESTAMP)#' "$$f"; \
rm -f "$$f.bak"; \
echo "Stamped $$f -> $(TIMESTAMP)"
endef

bump-version:
	@$(resolve-file); \
	$(stamp-file)

deploy:
	@$(resolve-file); \
	$(stamp-file); \
	git push origin $(BRANCH); \
	echo ""; \
	echo "Pushed. GitHub's raw CDN may take ~1-5 min to reflect changes."; \
	echo "Trigger 'Check for userscript updates' in Tampermonkey (Zen and Chrome, each independently),"; \
	echo "or wait for its periodic auto-check."; \
	echo ""; \
	echo "NOTE: the @version stamp above is uncommitted. Fold it into the summ: commit workflow."

open:
	@$(resolve-file); \
	url="$(RAW_BASE)/$$f"; \
	cmd.exe /c start "" "$$url" 2>/dev/null || \
	open "$$url" 2>/dev/null || \
	xdg-open "$$url" 2>/dev/null || \
	echo "Could not auto-open. Paste this URL into your browser: $$url"

# ---- bulk -----------------------------------------------------------------

CHANGED := $(sort $(shell git diff --name-only --relative HEAD -- '*.user.js'; git ls-files --others --exclude-standard -- '*.user.js'))
FILES   := $(if $(ALL),$(SCRIPTS),$(CHANGED))

_require-files:
	@if [ -z "$(strip $(FILES))" ]; then echo "No changed userscripts (use ALL=1 for every script)." >&2; exit 1; fi

list-changed: _require-files
	@for f in $(FILES); do echo "  $$f  ->  $(RAW_BASE)/$$f"; done

bump-version-all: _require-files
	@for f in $(FILES); do $(stamp-file); done

deploy-all: bump-version-all
	@git push origin $(BRANCH); \
	echo ""; \
	echo "Pushed. GitHub's raw CDN may take ~1-5 min to reflect changes."; \
	echo "Trigger 'Check for userscript updates' in Tampermonkey (Zen and Chrome, each independently),"; \
	echo "or wait for its periodic auto-check."; \
	echo ""; \
	echo "NOTE: the @version stamps above are uncommitted. Fold them into the summ: commit workflow."

open-all: _require-files
	@for f in $(FILES); do \
		url="$(RAW_BASE)/$$f"; \
		cmd.exe /c start "" "$$url" 2>/dev/null || \
		open "$$url" 2>/dev/null || \
		xdg-open "$$url" 2>/dev/null || \
		echo "Could not auto-open: $$url"; \
	done
