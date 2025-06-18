.PHONY: all dev clean release debug build format

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

format:
	clang-format -i $(SRCS) $(wildcard ./*.h)
