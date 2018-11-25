#!/bin/sh

usage() {
  cat <<USAGE
Usage: $0 [REPO_DIR] [TARGET_DIR]
USAGE
}

if [ $# -ne 2 ]; then
  usage
  exit 1
fi

REPO_DIR=`echo "$1" | sed -e 's|/$||g'`
TARGET_DIR=`echo "$2" | sed -e 's|/$||g'`

echo "REPO_DIR=$REPO_DIR, TARGET_DIR=$TARGET_DIR"
echo -n "Are you OK? (y): "
read yes

if [ $yes = "y" ]; then
  for d in "bash" "vim" "nvim" "scrips" "tmux"; do
    rm -f $TARGET_DIR/$d
    ln -s $REPO_DIR/$d $TARGET_DIR/$d
    echo "Linked $REPO_DIR/$d -> $TARGET_DIR/$d"
  done

  rm -f $HOME/.vimrc
  ln -s $TARGET_DIR/vim/.vimrc $HOME/.vimrc
  echo "Linked $REPO_DIR/vim/.vimrc -> $HOME/.vimrc"

  rm -f $HOME/.tmux.conf
  ln -s $TARGET_DIR/tmux/.tmux.conf $HOME/.tmux.conf
  echo "Linked $REPO_DIR/tmux/.tmux.conf -> $HOME/.tmux.conf"

  echo "Add the following line to your .bashrc (.bash_profile)"
  echo "source $TARGET_DIR/bash/.bashrc"

else
  echo "Canceled"
  exit 1
fi
