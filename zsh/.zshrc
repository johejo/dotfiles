### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting

zinit load zdharma/history-search-multi-word
zinit load agkozak/zsh-z

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure

zinit load zsh-users/zsh-completions

zinit ice lucid wait"0" depth"1" blockf
zinit light yuki-ycino/fzf-preview.zsh
bindkey '^i' fzf-or-normal-completion

autoload -U compinit && compinit

autoload -U bashcompinit
bashcompinit

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

setopt histignorealldups sharehistory globdots
bindkey -e

zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' completer _expand _complete _correct _approximate
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"

case $(uname -s) in
  Darwin* )
    source "$HOME/.config/zsh/.zshrc.darwin";;
  Linux* )
    source "$HOME/.config/zsh/.zshrc.linux";;
esac

export LANG="en_US.UTF-8"

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

if type go >/dev/null 2>&1; then
  export PATH=$(go env GOPATH)/bin:$PATH
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

if type fzf >/dev/null 2>&1; then
  export FZF_TMUX=1
  if type fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  fi
fi

alias grep='grep --color=auto'

alias ymd='date +%F'
alias ymdhms='date +%FT%T'
alias ymdhmst='date +%FT%T%:z'
alias es="exec $SHELL"

if type bat >/dev/null 2>&1; then
  alias cat="bat"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if type exa >/dev/null 2>&1; then
  alias ls="exa"
  alias l="exa"
  alias ll="exa -lahF"
fi

if type python3 >/dev/null 2>&1; then
  alias pip="pip3"
  alias python="python3"
fi

ghq-fzf() {
  cd "$(ghq root)/$(ghq list | fzf)"
  clear
}

if type terraform >/dev/null 2>&1; then
  complete -o nospace -C $(which terraform) terraform
fi

export TERM=xterm-256color
