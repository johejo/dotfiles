export PS1="\W$ "
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$XDG_CONFIG_HOME/scrips
export LANG="ja_JP.UTF-8"
export LC_ALL="ja_JP.UTF-8"
export EDITOR="vim"
export TERM="xterm"
export BASH_CONFIG_DIR=$XDG_CONFIG_HOME/bash
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE=on
export PATH=$PATH:$HOME/bin
export TERM=screen-256color

if [ -f $BASH_CONFIG_DIR/.bash_aliases ]; then
  source $BASH_CONFIG_DIR/.bash_aliases
fi

if [ -f $BASH_CONFIG_DIR/.bash_completion ]; then
  source $BASH_CONFIG_DIR/.bash_completion
fi
