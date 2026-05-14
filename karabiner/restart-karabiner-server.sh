#!/usr/bin/env bash
# desc: Restart Karabiner server

# declare -r _self_path_file_=$(readlink -f "$0")
# declare -r _self_path_dir_=$(dirname "${_self_path_file_}")

fn_restart_karabiner_server() {
  launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server

  if [ $? -eq 0 ]; then
    echo 'Karabiner server restarted successfully'
  else
    echo 'Karabiner server restart failed'
  fi
}

fn_restart_karabiner_server "$@"
