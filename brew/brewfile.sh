#!/usr/bin/env bash
# alias: 'n/a'
# desc: Manage Homebrew Bundle operations (dump/install) with OS-aware Brewfile selection.
# usage: fn_brewfile.sh [--dump | -d | --install | -i] [Brewfile_name]

declare -r _self_path_file_=$(readlink -f "$0")
declare -r _self_path_dir_=$(dirname "${_self_path_file_}")

fn_brewfile() {
  local arg_1=$1

  # detect OS and set appropriate Brewfile
  if [[ "$OSTYPE" == "darwin"* ]]; then
    local filename=${2:-'Brewfile'}
  else
    local filename=${2:-'LinuxBrewfile'}
  fi

  local brewfile_path="${_self_path_dir_}/${filename}"

  # if no args
  if [ -z "${arg_1}" ]; then
    echo 'No arguments provided.'
    echo 'Usage: fn_brewfile.sh [args]'
    echo 'Args:'
    echo '  --dump or -d'
    echo '  --install or -i'
    return
  fi

  # if arg = --dump or -d
  if [ "${arg_1}" = "--dump" ] || [ "${arg_1}" = "-d" ]; then
    echo 'Dumping Brewfile..'
    fn_brewfile_dump
  fi

  # if arg = --install or -i
  if [ "${arg_1}" = "--install" ] || [ "${arg_1}" = "-i" ]; then
    echo 'Installing Brewfile..'
    fn_brewfile_install
  fi
}

fn_brewfile_install() {
  echo 'fn_brewfile_install'
  brew bundle --verbose --file="${brewfile_path}"
}

fn_brewfile_dump() {
  echo 'fn_brewfile_dump'
  brew bundle dump --force --no-winget --file="${brewfile_path}"
}

fn_brewfile "$@"
