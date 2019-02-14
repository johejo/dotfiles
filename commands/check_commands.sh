#!/usr/bin/env bash

set -euC

readonly repo_dir=$(git rev-parse --show-toplevel)
readonly commands_dir=$repo_dir/commands

while read -r cmd; do
  if type "$cmd" > /dev/null 2>&1; then
    echo "$cmd OK"
  else
    echo "$cmd NG"
  fi
done < "$commands_dir/commands.txt"
