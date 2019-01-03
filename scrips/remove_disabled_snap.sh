#!/bin/sh

if type snap > /dev/null 2>&1; then
  snap list --all | grep disabled | awk '{print $1,$3}' |
    while read -r name rev; do
      sudo snap remove "$name" --revision "$rev";
    done
fi
