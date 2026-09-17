# Makefile for managing Tampermonkey scripts in this repo.
# Auto-discovers every *.user.js file in this directory.
#
# Usage:
#   make list                          list all tracked userscripts + their raw URLs
#   make deploy                        stamp @version on changed scripts, then git push
#   make deploy FILE=name.user.js      stamp @version on exactly one script, then git push
#   make open FILE=name.user.js        open one script's raw URL (first-time install)
#   make open                          list raw URLs without opening (pick one manually)
#
# @version is stamped with the current time (YYYY.MM.DD.HHMMSS) so Tampermonkey
# treats every push as a real update. Every script with an uncommitted change
# vs HEAD is stamped by default.

REPO     := frizadiga/dotfiles
BRANCH   := main
DIR      := tampermonkey
RAW_BASE := https://raw.githubusercontent.com/$(REPO)/$(BRANCH)/$(DIR)

SCRIPTS   := $(wildcard *.user.js)
TIMESTAMP := $(shell date +%Y.%m.%d.%H%M%S)

.PHONY: deploy bump-version open _open list

list:
	@echo "Tracked userscripts:"
	@for f in $(SCRIPTS); do echo "  $$f  ->  $(RAW_BASE)/$$f"; done

# Stamp @version so Tampermonkey treats the next fetch as a real update.
# (Tampermonkey compares @version; unchanged version = silently ignored.)
# Default: any script with an uncommitted working-tree change vs HEAD
# (FILE= overrides to stamp exactly one).
CHANGED := $(shell git diff --name-only --relative HEAD -- '*.user.js')

FILES := $(if $(FILE),$(FILE),$(CHANGED))

define bump-files
	@for f in $(FILES); do \
		sed -i.bak 's#^\(\/\/[[:space:]]*@version[[:space:]]*\).*#\1$(TIMESTAMP)#' "$$f"; \
		rm -f "$$f.bak"; \
		echo "Stamped $$f -> $(TIMESTAMP)"; \
	done
endef

bump-version:
	$(bump-files)

deploy: bump-version
	git push origin $(BRANCH)
	@echo ""
	@echo "Pushed. GitHub's raw CDN may take ~1-5 min to reflect changes."
	@echo "Trigger 'Check for userscript updates' in Tampermonkey (Zen and Chrome, each independently),"
	@echo "or wait for its periodic auto-check."
	@echo ""
	@echo "NOTE: the @version stamp(s) above are uncommitted. Fold them into `summ:` commit workflow."

open:
ifdef FILE
	@$(MAKE) --no-print-directory _open URL="$(RAW_BASE)/$(FILE)"
else
	@echo "Specify a file, e.g.: make open FILE=tv-auto-workspace-only-mode.user.js"
	@echo ""
	@$(MAKE) --no-print-directory list
endif

_open:
	@cmd.exe /c start "" "$(URL)" 2>/dev/null || \
	 open "$(URL)" 2>/dev/null || \
	 xdg-open "$(URL)" 2>/dev/null || \
	 echo "Could not auto-open. Paste this URL into your browser: $(URL)"
