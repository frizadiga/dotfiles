#!/usr/bin/env bash
# alias: 'n/a'
# desc: fn_brewfile description.
# usage: fn_brewfile.sh [args]
# flags: @WIP:0 @TODO:0 @FIXME:0 @BUG:0 @OPTIMIZE:0 @REFACTOR:0 @DEPRECATED:0

declare -r _self_path_file_=$(readlink -f "$0")
declare -r _self_path_dir_=$(dirname "${_self_path_file_}")

source "${TOOLS_DIR}/ansi-utils.sh"
# source "$HOME/Documents/main/tools/aliases"

# check if script run directly or indirect
# if [ "${0}" = "${BASH_SOURCE}" ]; then
#   echo "Script is being run directly"
# else
#   echo "Script is being sourced"
# fi

local brewfile_path="${_self_path_dir_}/Brewfile"

fn_brewfile() {
  # echo $(yellow $(bold 'fn_brewfile'))
  local arg_1=$1

  # if no args
  if [ -z "${arg_1}" ]; then
    echo $(red $(bold 'No arguments provided.'))
    echo $(yellow $(bold 'Usage: fn_brewfile.sh [args]'))
    echo $(yellow $(bold 'Args:'))
    echo $(yellow $(bold '  --dump or -d'))
    echo $(yellow $(bold '  --install or -i'))
    return
  fi

  # if arg = --dump or -d
  if [ "${arg_1}" = "--dump" ] || [ "${arg_1}" = "-d" ]; then
    echo $(green $(bold 'Dumping Brewfile..'))
    fn_brewfile_dump
  fi

  # if arg = --install or -i
  if [ "${arg_1}" = "--install" ] || [ "${arg_1}" = "-i" ]; then
    echo $(green $(bold 'Installing Brewfile..'))
    fn_brewfile_install
  fi
}

fn_brewfile_install() {
  echo $(yellow $(bold 'fn_brewfile_install'))
  brew bundle --verbose --file="${brewfile_path}"
}

fn_brewfile_dump() {
  echo $(yellow $(bold 'fn_brewfile_dump'))
  brew bundle dump --force --file="${brewfile_path}" --describe
}

fn_brewfile "$@"
