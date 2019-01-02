#!/usr/bin/env bash

command_not_found_handle ()
{
  if [ -x /usr/lib/command-not-found ]; then
    /usr/lib/command-not-found -- "$1"
    return $?
  elif [ -x /usr/share/command-not-found/command-not-found ]; then
    /usr/share/command-not-found/command-not-found -- "$1"
    return $?
  elif type brew > /dev/null 2>&1; then
    brew search $1
    return $?
  else
    printf "%s: command not found\n" "$1" 1>&2;
    return 127
  fi
}

./check_commands.sh |
while read cmd judge; do
  if [ $judge == "NG" ]; then
    command_not_found_handle $cmd
  fi
done
