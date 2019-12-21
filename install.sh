#!/usr/bin/env bash

usage() {
  cat <<USAGE
Usage: $0 [TARGET_DIR]
USAGE
}

if [ $# -ne 2 ]; then
  usage
  exit 1
fi

REPO_DIR=$(pwd)
TARGET_DIR=$(echo "$2" | sed -e 's|/$||g')

echo "REPO_DIR=$REPO_DIR, TARGET_DIR=$TARGET_DIR"
echo "Are you OK? (y)"
read -r yes

if [ "$yes" != "y" ]; then
  echo "Canceled"
  exit 1
fi

echo
mkdir -p "$TARGET_DIR"

for d in "bash" "vim" "nvim" "scrips" "tmux" "ctags" "fish" "zsh" "ideavim"; do
  rm -rf "${TARGET_DIR:?}/$d"
  ln -s "${REPO_DIR:?}/$d" "${TARGET_DIR:?}/$d"
  echo "Linked $REPO_DIR/$d -> $TARGET_DIR/$d"
done

rm -f "${HOME:?}/.vimrc"
ln -s "${TARGET_DIR:?}/vim/.vimrc" "${HOME:?}/.vimrc"
echo "Linked $TARGET_DIR/vim/.vimrc -> $HOME/.vimrc"

rm -f "${HOME:?}/.ideavimrc"
ln -s "${TARGET_DIR:?}/ideavim/.ideavimrc" "${HOME:?}/.ideavimrc"
echo "Linked $TARGET_DIR/ideavim/.ideavimrc -> $HOME/.ideavimrc"

rm -rf "${HOME:?}/.vim"
ln -s "${TARGET_DIR:?}/vim/.vim" "${HOME:?}/.vim"
echo "Linked $TARGET_DIR/vim/.vim -> $HOME/.vim"

rm -f "${HOME:?}/.tmux.conf"
ln -s "${TARGET_DIR:?}/tmux/.tmux.conf" "${HOME:?}/.tmux.conf"
echo "Linked $TARGET_DIR/tmux/.tmux.conf -> $HOME/.tmux.conf"

rm -f "${HOME:?}/.ctags"
ln -s "${TARGET_DIR:?}/ctags/.ctags" "${HOME:?}/.ctags"
echo "Linked $TARGET_DIR/.ctags -> $HOME/.ctags"

echo
echo "Add the following line to your .bashrc (.bash_profile)"
echo "source $TARGET_DIR/bash/.bashrc"

echo
echo "Add the following line to your .zshrc"
echo "source $TARGET_DIR/zsh/.zshrc"
