#!/bin/sh

set -euC

uname -a | grep "$1" > /dev/null 2>&1

ret=$?

echo $ret

if [ $ret != 0 ]; then
  echo NG
  exit 1
fi
