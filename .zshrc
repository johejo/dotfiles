bindkey -e

eval "$(starship init zsh)"

alias es="exec $SHELL -l"
alias ls="exa"
alias ll="exa -al"
alias cat="bat"

export FZF_DEFAULT_OPTS="--layout=reverse"
export EDITOR="nvim"
export GPG_TTY=$(tty)

function gcd {
  cd "$(ghq root)/$(ghq list | fzf)/"
}

eval "$($HOME/go/bin/safepathexport -key PATH -value $HOME/go/bin -push)"

eval "$(safepathexport -key PATH -value $HOME/.local/bin -push)"

eval "$(safepathexport -key PATH -value $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin)"
eval "$(safepathexport -key PATH -value $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin)"
eval "$(safepathexport -key PATH -value $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin)"
eval "$(safepathexport -key PATH -value $HOMEBREW_PREFIX/opt/gnu-time/libexec/gnubin)"
eval "$(safepathexport -key PATH -value $HOMEBREW_PREFIX/opt/grep/libexec/gnubin)"
eval "$(safepathexport -key PATH -value $HOMEBREW_PREFIX/opt/make/libexec/gnubin)"
eval "$(safepathexport -key PATH -value $HOMEBREW_PREFIX/opt/node@16/bin)"
eval "$(safepathexport -key PATH -value $HOMEBREW_PREFIX/opt/openjdk/bin)"

eval "$(safepathexport -key MANPATH -value $HOMEBREW_PREFIX/opt/coreutils/libexec/man)"
eval "$(safepathexport -key MANPATH -value $HOMEBREW_PREFIX/opt/gnu-tar/libexec/man)"
eval "$(safepathexport -key MANPATH -value $HOMEBREW_PREFIX/opt/gnu-sed/libexec/man)"
eval "$(safepathexport -key MANPATH -value $HOMEBREW_PREFIX/opt/gnu-time/libexec/man)"
eval "$(safepathexport -key MANPATH -value $HOMEBREW_PREFIX/opt/grep/libexec/man)"
eval "$(safepathexport -key MANPATH -value $HOMEBREW_PREFIX/opt/make/libexec/man)"
eval "$(safepathexport -key MANPATH -value $HOMEBREW_PREFIX/opt/node@16/share/man)"
eval "$(safepathexport -key MANPATH -value $HOMEBREW_PREFIX/opt/openjdk/share/man)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit load zdharma-continuum/history-search-multi-word
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions

FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"
FPATH="$HOMEBREW_PREFIX/completions/zsh:$FPATH"

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _oldlist _complete _ignored
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=1

autoload -Uz compinit && compinit
autoload -U bashcompinit && bashcompinit
