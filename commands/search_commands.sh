#!/usr/bin/env bash

set -euC

readonly repo_dir=$(git rev-parse --show-toplevel)
readonly commands_dir=$repo_dir/commands

handle_command_not_found ()
{
  if [ -x /usr/lib/command-not-found ]; then
    /usr/lib/command-not-found -- "$1"
    return $?
  elif [ -x /usr/share/command-not-found/command-not-found ]; then
    /usr/share/command-not-found/command-not-found -- "$1"
    return $?
  elif type brew > /dev/null 2>&1; then
    brew search "$1"
    return $?
  else
    printf "%s: command not found\\n" "$1" 1>&2;
    return 127
  fi
}

"$commands_dir/check_commands.sh" |
while read -r cmd judge; do
  if [ "$judge" == "NG" ]; then
    handle_command_not_found "$cmd"
  fi
done
