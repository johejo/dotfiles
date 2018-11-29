#!/bin/sh

REMOTE_URL="https://httpbin.org/ip"
IPADDR_PATTERN="([0-9]+.){3}[0-9]+" # This is not an appropriate regular expression to match an IP address.

if type curl > /dev/null 2>&1; then
  curl -sSL $REMOTE_URL | awk -v p=$IPADDR_PATTERN '{if(match($0,p)) print substr($0, RSTART, RLENGTH)}'
elif type wget > /dev/null 2>&1; then
  wget -q -O - $REMOTE_URL | awk -v p=$IPADDR_PATTERN '{if(match($0,p)) print substr($0, RSTART, RLENGTH)}'
else
  echo "\'curl\' or \'wget\' not found."
  exit 1
fi
