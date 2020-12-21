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
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting
zinit load zdharma/history-search-multi-word

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PREFIX="$(brew --prefix)"
source "$PREFIX/opt/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

unsetopt flow_control
bindkey -e

fpath+=($PREFIX/share/zsh/site-functions)
fpath+=($PREFIX/Homebrew/completions/zsh)

autoload -Uz compinit
compinit
autoload -U bashcompinit
bashcompinit

alias ls="exa"
alias ll="exa -lah"
alias es="exec $SHELL"

UNAME=$(uname -s)

export TERM=xterm-256color
if [[ $UNAME = "Darwin" ]]; then
  export PATH="$PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi
export FZF_DEFAULT_OPTS="--layout=reverse"
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'

if type nvim >/dev/null 2>&1; then
  export EDITOR=nvim
fi

eval "$(dircolors)"

zstyle ':completion:*' menu true select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' completer _expand _complete _correct _approximate

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function gcd() {
  ghq_root=$(ghq root)
  target=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $ghq_root/{}/README.*")
  cd "$ghq_root/$target"
  clear
}

export PATH="$PATH:$HOME/go/bin"
