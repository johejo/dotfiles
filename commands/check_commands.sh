#!/bin/sh

cat commands.txt |
while read cmd; do
  if type $cmd > /dev/null 2>&1; then
    echo "$cmd OK"
  else
    echo "$cmd NG"
  fi
done
