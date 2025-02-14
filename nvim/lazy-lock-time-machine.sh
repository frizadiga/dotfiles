#!/usr/bin/env bash
# alias: 'n/a'
# desc: fn_lazy_lock_time_machine description.
# usage: fn_lazy_lock_time_machine.sh [args]
# flags: @WIP:0 @TODO:0 @FIXME:0 @BUG:0 @OPTIMIZE:0 @REFACTOR:0 @DEPRECATED:0

# declare -r _self_path_file_=$(readlink -f "$0")
# declare -r _self_path_dir_=$(dirname "${_self_path_file_}")
# echo [DEBUG] _self_path_dir_: "${_self_path_dir_}"

source "${TOOLS_DIR}/ansi-utils.sh"
# source "$HOME/Documents/main/tools/aliases"

# check if script run directly or indirect
# if [ "${0}" = "${BASH_SOURCE}" ]; then
#   echo "Script is being run directly"
# else
#   echo "Script is being sourced"
# fi

fn_lazy_lock_time_machine() {
  local commit_hash=${1}
  # script for reset nvim lazy-lock
  if [ -z "${commit_hash}" ]; then
    echo $(red $(bold 'Please provide commit hash'))
    return 1
  fi

  git checkout "${commit_hash}" -- "${DOTFILES_HOME}/nvim/lazy-lock.json"
}

fn_lazy_lock_time_machine "$@"
