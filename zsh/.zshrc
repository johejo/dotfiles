case $(uname -s) in
  Darwin* )
    source "$HOME/.config/zsh/.zshrc.darwin";;
  Linux* )
    source "$HOME/.config/zsh/.zshrc.linux";;
esac

fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory globdots

bindkey -e

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit
autoload -U bashcompinit
bashcompinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:default' menu select=1

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin ice wait"0" blockf
zplugin light zsh-users/zsh-completions

zplugin ice wait"0" atload"_zsh_autosuggest_start"
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait"0" atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
prompt pure

export LANG="ja_JP.UTF-8"

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/bin$PATH
export PATH=$HOME/.local/bin:$PATH

if type go >/dev/null 2>&1; then
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH
  export GO111MODULE=on
fi

if type pipenv >/dev/null 2>&1; then
  export PIPENV_VENV_IN_PROJECT=true
fi

if type yarn >/dev/null 2>&1; then
  export PATH=$HOME/.yarn/bin:$PATH
fi

if type nvim >/dev/null 2>&1; then
  export EDITOR=nvim
elif type vim >/dev/null 2>&1; then
  export EDITOR=vim
elif type vi >/dev/null 2>&1; then
  export EDITOR=vi
fi

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'

alias ymd='date +%F'
alias ymdhms='date +%FT%T'
alias ymdhmst='date +%FT%T%:z'
