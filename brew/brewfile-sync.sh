#!/usr/bin/env bash
# alias: 'n/a'
# desc: fn_brewfile_sync description.
# usage: fn_brewfile_sync.sh [args]
# flags: @WIP:0 @TODO:0 @FIXME:0 @BUG:0 @OPTIMIZE:0 @REFACTOR:0 @DEPRECATED:0

# declare -r _self_path_file_=$(readlink -f "$0")
# declare -r _self_path_dir_=$(dirname "${_self_path_file_}")
# echo [DEBUG] _self_path_dir_: "${_self_path_dir_}"

source "${TOOLS_DIR}/ansi-utils.sh"
# source "$HOME/Documents/tools/aliases"

# check if script run directly or indirect
# if [ "${0}" = "${BASH_SOURCE}" ]; then
#   echo "Script is being run directly"
# else
#   echo "Script is being sourced"
# fi

fn_brewfile_sync() {
  echo $(yellow $(bold 'fn_brewfile_sync'))
  brew bundle dump --file=./Brewfile --describe
}

fn_brewfile_sync "$@"
