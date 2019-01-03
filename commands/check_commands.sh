#!/bin/sh

while read -r cmd; do
  if type "$cmd" > /dev/null 2>&1; then
    echo "$cmd OK"
  else
    echo "$cmd NG"
  fi
done < commands.txt
