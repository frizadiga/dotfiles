# Makefile for managing Tampermonkey scripts in this repo.
# Auto-discovers every *.user.js file in this directory.
#
# Usage:
#   make list                          list all tracked userscripts + their raw URLs
#   make deploy                        bump @version in ALL scripts, then git push
#   make deploy FILE=name.user.js      bump @version in just one script, then git push
#   make deploy VERSION=x.y.z          set ALL scripts to exactly x.y.z, then git push
#   make open FILE=name.user.js        open one script's raw URL (first-time install)
#   make open                          list raw URLs without opening (pick one manually)
#
# @version follows semver, bumped per script:
#   X.Y.Z  -> X.Y.(Z+1)   (patch bump)
#   X.Y    -> X.Y.0       (e.g. "1.0" becomes "1.0.0")
#   other  -> 1.0.0       (e.g. date-style versions get normalized)

REPO     := frizadiga/dotfiles
BRANCH   := main
DIR      := tampermonkey
RAW_BASE := https://raw.githubusercontent.com/$(REPO)/$(BRANCH)/$(DIR)

SCRIPTS  := $(wildcard *.user.js)

.PHONY: deploy bump-version open _open list

list:
	@echo "Tracked userscripts:"
	@for f in $(SCRIPTS); do echo "  $$f  ->  $(RAW_BASE)/$$f"; done

# Bump @version so Tampermonkey treats the next fetch as a real update.
# (Tampermonkey compares @version; unchanged version = silently ignored.)
# Pass VERSION=x.y.z to force an exact version instead of auto-bumping.
FILES := $(if $(FILE),$(FILE),$(SCRIPTS))

define bump-files
	@for f in $(FILES); do \
		cur=$$(sed -n 's#^//[[:space:]]*@version[[:space:]]*##p' "$$f" | head -1); \
		$(if $(VERSION),new=$(VERSION),new=$$(printf '%s\n' "$$cur" | awk -F. ' \
		  $$1 ~ /^[0-9]+$$/ && $$2 ~ /^[0-9]+$$/ && $$3 ~ /^[0-9]+$$/ { v=$$3+1; printf "%s.%s.%d\n", $$1, $$2, v; exit } \
		  $$1 ~ /^[0-9]+$$/ && $$2 ~ /^[0-9]+$$/ { printf "%s.%s.0\n", $$1, $$2; exit } \
		  { printf "1.0.0\n" }')); \
		sed -i.bak 's#^\(\/\/[[:space:]]*@version[[:space:]]*\).*#\1'"$$new"'#' "$$f"; \
		rm -f "$$f.bak"; \
		echo "Bumped $$f -> $$new"; \
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
	@echo "NOTE: the version bump(s) above are uncommitted. Fold them into `summ:` commit workflow."

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
