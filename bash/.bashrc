export PS1="\\W$ "
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export LANG="ja_JP.UTF-8"
export LC_ALL="ja_JP.UTF-8"
export BASH_CONFIG_DIR=$XDG_CONFIG_HOME/bash
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/bin
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$XDG_CONFIG_HOME/scrips
export PIPENV_VENV_IN_PROJECT=true

if type nvim > /dev/null 2>&1; then
  export EDITOR=nvim
elif type vim > /dev/null 2>&1; then
  export EDITOR=vim
elif type vi > /dev/null 2>&1; then
  export EDITOR=vi
fi

if [ -f "${BASH_CONFIG_DIR:?}/.bash_aliases" ]; then
  source "${BASH_CONFIG_DIR:?}/.bash_aliases"
fi

if [ -f "${BASH_CONFIG_DIR:?}/.bash_completion" ]; then
  source "${BASH_CONFIG_DIR:?}/.bash_completion"
fi
