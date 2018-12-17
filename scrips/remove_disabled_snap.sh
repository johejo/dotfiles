#!/bin/sh

if type snap 2>&1 > /dev/null; then
  sudo snap list --all | grep disabled | awk '{print $1,$3}' |
    while read name rev; do
      sudo snap remove $name --revision $rev;
    done
fi
