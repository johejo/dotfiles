#!/bin/sh

uname -a | grep "$1" > /dev/null 2>&1

ret=$?

if [ $ret != 0 ]; then
  exit 1
fi
