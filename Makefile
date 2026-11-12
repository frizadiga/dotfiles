.PHONY: init sync wsl wsl-install

init:
	git submodule update --init --recursive
	git submodule foreach 'git restore --staged . 2>/dev/null; git checkout . 2>/dev/null; true'
	git config merge.ours.driver true
	git update-index --assume-unchanged ./btop/btop.conf

# Pull from origin while preserving the live btop config.
#
# btop rewrites ./btop/btop.conf at runtime (it is symlinked from
# ~/.config/btop/btop.conf), which leaves the tracked file permanently dirty
# and makes a plain `git pull` abort with "local changes would be overwritten".
# The assume-unchanged/merge=ours setup does not bypass git's pre-pull check.
#
# This target stashes the live file aside, restores the committed copy so the
# pull can run, pulls, then puts the live file back and re-hides it.
sync:
	@set -e; \
	_live="$$(mktemp)"; \
	_had_conf=0; \
	_restore() { \
		if [ "$$_had_conf" -eq 1 ] && [ -f "$$_live" ]; then \
			cp -p "$$_live" btop/btop.conf; \
		fi; \
		git update-index --assume-unchanged ./btop/btop.conf 2>/dev/null || true; \
		rm -f "$$_live"; \
	}; \
	trap _restore EXIT INT TERM; \
	if [ -f btop/btop.conf ]; then cp -p btop/btop.conf "$$_live"; _had_conf=1; fi; \
	git update-index --no-assume-unchanged ./btop/btop.conf 2>/dev/null || true; \
	git checkout -- btop/btop.conf 2>/dev/null || true; \
	git pull --no-edit; \
	git submodule update --init --recursive

wsl: wsl-install
wsl-install:
	$(MAKE) -C wsl install
