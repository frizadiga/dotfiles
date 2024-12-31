#!/usr/bin/env bash
# alias: 'n/a'
# desc: fn_alttab_config description.
# usage: fn_alttab_config.sh [args]
# flags: @WIP:0 @TODO:0 @FIXME:0 @BUG:0 @OPTIMIZE:0 @REFACTOR:0 @DEPRECATED:0

declare -r _self_path_file_=$(readlink -f "$0")
declare -r _self_path_dir_=$(dirname "${_self_path_file_}")
# echo [DEBUG] _self_path_dir_: "${_self_path_dir_}"

# source "${TOOLS_DIR}/ansi-utils.sh"
# source "$HOME/Documents/tools/aliases"

# check if script run directly or indirect
# if [ "${0}" = "${BASH_SOURCE}" ]; then
#   echo "Script is being run directly"
# else
#   echo "Script is being sourced"
# fi

fn_alttab_config() {
  # echo $(red $(bold 'fn_alttab_config'))
  local arg0="${1}"

  if [ -z "${arg0}" ]; then
    echo 'Usage: alttab-config.sh [args]'
    echo '  -i: import alttab-config'
    echo '  -b: backup alttab-config'
    return 1
  fi

  # set config
  if [ "${arg0}" = "-i" ]; then
    echo "import alttab-config"
    defaults import com.lwouis.alt-tab-macos "${_self_path_dir_}/com.lwouis.alt-tab-macos.plist"
    exit $?
  fi

  # backup config
  if [ "${arg0}" = "-b" ]; then
    echo "backup alttab-config"
    defaults export com.lwouis.alt-tab-macos "${_self_path_dir_}/com.lwouis.alt-tab-macos.plist"
    exit $?
  fi
}

fn_alttab_config "$@"
