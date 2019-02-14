#!/usr/bin/env bash

set -euC

readonly repo_dir=$(git rev-parse --show-toplevel)
readonly commands_dir=$repo_dir/commands

sort -u "$commands_dir/commands.txt" -o "$commands_dir/commands.txt"
