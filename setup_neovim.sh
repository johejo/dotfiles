#!/usr/bin/env bash

if type python3 >/dev/null 2>&1; then
  venv_dir=$HOME/.venv
  neovim_venv_dir="$venv_dir/neovim"
  rm -rf "$neovim_venv_dir"
  mkdir -p "$neovim_venv_dir"
  python3 -m venv "$neovim_venv_dir"
  source "$neovim_venv_dir/bin/activate"
  pip3 install --upgrade neovim
  deactivate
fi
