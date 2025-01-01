#!/usr/bin/env bash
# alias: 'n/a'
# desc: fn_restart_karabiner_server description.
# usage: fn_restart_karabiner_server.sh [args]
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

fn_restart_karabiner_server() {
  echo $(orange $(bold 'fn_restart_karabiner_server'))

  launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server

  if [ $? -eq 0 ]; then
    echo $(green $(bold 'Karabiner server restarted successfully'))
  else
    echo $(red $(bold 'Karabiner server restart failed'))
  fi
}

fn_restart_karabiner_server "$@"
