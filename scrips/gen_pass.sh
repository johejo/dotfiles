#!/usr/bin/env bash

set -euC

if [ -z "$1" ]; then
  length=10
else
  length=$1
fi

openssl rand -base64 "$length"
