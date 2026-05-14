#!/usr/bin/env bash
# desc: fn_alttab_config description.

declare -r _self_path_file_=$(readlink -f "$0")
declare -r _self_path_dir_=$(dirname "${_self_path_file_}")


fn_alttab_config() {
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
