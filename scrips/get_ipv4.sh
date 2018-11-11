#!/bin/sh

interface="$1"

if type ip > /dev/null 2>&1; then
  ip a show $interface | grep "inet " | awk '{print $2}' | sed -e 's|/[0-9]\+||g'
elif type ifconfig > /dev/null 2>&1; then
  ifconfig $interface | grep "inet " | awk '{print $2}'
else
  echo "Commands \'ip\' or \'ifconfig not found"
  exit 1
fi
