#!/usr/bin/env bash

usage() {
  cat <<USAGE
Usage: $0 [REPO_DIR] [TARGET_DIR]
USAGE
}

if [ $# -ne 2 ]; then
  usage
  exit 1
fi

REPO_DIR=$(echo "$1" | sed -e 's|/$||g')
TARGET_DIR=$(echo "$2" | sed -e 's|/$||g')

echo "REPO_DIR=$REPO_DIR, TARGET_DIR=$TARGET_DIR"
echo "Are you OK? (y)"
read -r yes

if [ "$yes" != "y" ]; then
  echo "Canceled"
  exit 1
fi

for d in "bash" "vim" "nvim" "scrips" "tmux" "ctags" "fish" "zsh"; do
  unlink "${TARGET_DIR:?}/$d"
  echo "Unlinked $REPO_DIR/$d -> $TARGET_DIR/$d"
done

unlink "${HOME:?}/.vimrc"
echo "Unlinked $TARGET_DIR/vim/.vimrc -> $HOME/.vimrc"

unlink "${HOME:?}/.ideavimrc"
echo "Unlinked $TARGET_DIR/ideavim/.ideavimrc -> $HOME/.ideavimrc"

unlink "${HOME:?}/.vim"
echo "Unlinked $TARGET_DIR/vim -> $HOME/.vim"

unlink "${HOME:?}/.tmux.conf"
echo "Unlinked $TARGET_DIR/tmux/.tmux.conf -> $HOME/.tmux.conf"

unlink "${HOME:?}/ctags/.ctags"
echo "Unlinked $TARGET_DIR/ctags/.ctags -> $HOME/.ctags"

unlink "${HOME:?}/.zshrc"
echo "Unlinked $TARGET_DIR/zsh/.zshrc -> $HOME/.zshrc"
