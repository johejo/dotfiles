#!/bin/sh

arg="$1"
uname -a | grep $arg > /dev/null 2>&1

ret=$?

if [ $ret != 0 ]; then
  exit 1
fi
