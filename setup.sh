#!/bin/sh

REPO_DIR=`echo "$1" | sed -e 's|/$||g'`
TARGET_DIR=`echo "$2" | sed -e 's|/$||g'`

echo "REPO_DIR=$REPO_DIR, TARGET_DIR=$TARGET_DIR"
echo "Are you OK? (y)"
read yes

if [ yes = "y" ]; then
  for d in "bash" "nvim" "scrips"; do
    rm -f $TARGET_DIR/$d
    ln -s $REPO_DIR/$d $TARGET_DIR/$d
  done
else
  exit 1
fi
