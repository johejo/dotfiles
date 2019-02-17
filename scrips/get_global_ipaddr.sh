#!/usr/bin/env bash

set -euC

REMOTE_URL="https://httpbin.org/ip"
IPADDR_PATTERN="([0-9]+.)+[0-9]+" # This is not an appropriate regular expression to match an IP address.

match_ip() {
  awk -v p="$IPADDR_PATTERN" '{if(match($0,p)) print substr($0, RSTART, RLENGTH)}'
}

if type curl >/dev/null 2>&1; then
  curl -sSL $REMOTE_URL | match_ip
elif type wget >/dev/null 2>&1; then
  wget -q -O - $REMOTE_URL | match_ip
else
  echo "'curl' or 'wget' not found."
  exit 1
fi
