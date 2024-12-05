#!/usr/bin/env bash
# alias: 'n/a'
# desc: install prerelease version of ghostty terminal emulator.
# usage: fn_ghostty_install.sh [args]
# flags: @WIP:1 @TODO:0 @FIXME:0 @BUG:0 @OPTIMIZE:0 @REFACTOR:0 @DEPRECATED:0

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

fn_ghostty_install() {
  echo $(orange $(bold 'fn_ghostty_install'))

  cd ${GHOSTTY_HOME}
  pwd # debug

  local archive_filename='ghostty-macos-universal.zip'

  if [ -f "${GHOSTTY_HOME}/${archive_filename}" ]; then
    echo "cleanup.."
    rm -rf ./* 
    # rm -f "${GHOSTTY_HOME}/${downloaded_filename}"
  fi

  gh auth status # check gh current logged in user

  # download "nightly" release
  gh release download tip --repo ghostty-org/ghostty --pattern "${archive_filename}"
  ls # debug

  if [ -f "./${archive_filename}" ]; then
    echo "file exists."
  else
    echo "file does not exist."
  fi

  unzip "./${archive_filename}"
  ls # debug

  open ./Ghostty.app
}

fn_ghostty_install "$@"
