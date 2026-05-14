#!/usr/bin/env bash
# alias: 'n/a'
# desc: install prerelease version of ghostty terminal emulator.

# declare -r _self_path_file_=$(readlink -f "$0")
# declare -r _self_path_dir_=$(dirname "${_self_path_file_}")

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
