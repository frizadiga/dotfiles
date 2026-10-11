# Makefile for the AutoHotkey window-switcher (Windows side, driven from WSL).
#
# Usage:
#   make install   deploy window-switch.ahk + Startup shortcut (idempotent)
#   make status    diff repo copy vs deployed copy, check shortcut + process

.PHONY: install deploy status

install:
	./install.sh

deploy: install

status:
	@echo "== repo vs deployed =="
	@deployed="/mnt/c/Users/$$(ls /mnt/c/Users 2>/dev/null | grep -v -E '^(Public|Default|Default User|All Users|desktop\.ini)$$' | head -1)/Documents/ahk/window-switch.ahk"; \
	if [ ! -f "$$deployed" ]; then \
		echo "not deployed (or not on WSL)"; \
	elif diff -q window-switch.ahk "$$deployed" >/dev/null; then \
		echo "in sync: $$deployed"; \
	else \
		echo "DIFFERS: $$deployed"; diff window-switch.ahk "$$deployed" || true; \
	fi
	@echo "== startup shortcut =="
	@ls -la "/mnt/c/Users/$$(ls /mnt/c/Users 2>/dev/null | grep -v -E '^(Public|Default|Default User|All Users|desktop\.ini)$$' | head -1)/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/window-switch.lnk" 2>/dev/null || echo "missing (or not on WSL)"
