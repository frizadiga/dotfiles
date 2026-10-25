.PHONY: install sync

# Try to get Windows username
WIN_USER := $(shell cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r\n')
ifeq ($(WIN_USER),)
WIN_USER := $(shell powershell.exe -NoProfile -Command '$env:USERNAME' 2>/dev/null | tr -d '\r\n')
endif

WIN_HOME := /mnt/c/Users/$(WIN_USER)
DEST := $(WIN_HOME)/.wslconfig
SRC := $(CURDIR)/.wslconfig

install: sync

sync:
	@test -n "$(WIN_USER)" || (echo "[ERR] Could not detect Windows username" && exit 1)
	@test -d "$(WIN_HOME)" || (echo "[ERR] $(WIN_HOME) not found" && exit 1)
	@echo "[INFO] Syncing $(SRC) -> $(DEST)"
	@cp -v "$(SRC)" "$(DEST)"
	@echo "[INFO] Done. Run 'wsl --shutdown' from PowerShell/Terminal and relaunch WSL to apply."
