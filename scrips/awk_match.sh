#!/bin/sh

set -euC

PATTERN="$1"

awk -v "p=$PATTERN" '{if(match($0,p)) print substr($0, RSTART, RLENGTH)}'
