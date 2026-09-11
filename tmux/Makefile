.PHONY: all dev clean release debug build format install install-tpm

CC = clang
CFLAGS = -Wall -Wextra -Werror -Wpedantic -std=c2x
CFLAGS_DEBUG = -g -O0
CFLAGS_RELEASE = -O2 -DNDEBUG
DEBUGGER = lldb
SRCS = $(wildcard ./*.c)
BIN_NAME = tmux-status-bar

all: dev

dev: build
	./$(BIN_NAME)

build:
	$(CC) $(CFLAGS) $(CFLAGS_DEBUG) $(SRCS) -o ./$(BIN_NAME)

release:
	$(CC) $(CFLAGS) $(CFLAGS_RELEASE) $(SRCS) -o ./$(BIN_NAME)

debug: build
	$(DEBUGGER) ./$(BIN_NAME)

clean:
	rm -rf ./$(BIN_NAME) /*.o *.dSYM

install: install-tpm
	@test -d ~/.tmux/plugins/tmux-float-term || \
	    git clone https://github.com/frizadiga/tmux-float-term.git ~/.tmux/plugins/tmux-float-term

install-tpm:
	@if uname -s | grep -q Darwin; then \
	    test -f /opt/homebrew/opt/tpm/share/tpm/tpm || brew install tpm; \
	else \
	    test -f /home/linuxbrew/.linuxbrew/opt/tpm/share/tpm/tpm || brew install tpm; \
	fi

format:
	clang-format -i $(SRCS) $(wildcard ./*.h)
