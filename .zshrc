bindkey -e

alias es='exec $SHELL'
alias ls="eza"
alias ll="eza -al"
alias cat="bat"
alias k="kubectl"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

export FZF_DEFAULT_OPTS="--layout=reverse"
export EDITOR="nvim"
export HISTSIZE=99999
export SAVEHIST=999999

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

function gcd {
	cd "$(ghq root)/$(ghq list | fzf)/" || exit
}

eval "$("$HOME/go/bin/safepathexport" -key PATH -value "$HOME/go/bin" -push)"

eval "$(safepathexport -key PATH -value "$HOME/.local/bin" -push)"
eval "$(safepathexport -key PATH -value "$HOME/.local/nvim/bin")"
eval "$(safepathexport -key PATH -value "$HOME/.krew/bin" -push)"
eval "$(safepathexport -key PATH -value "$HOME/.cargo/bin" -push)"
#eval "$(safepathexport -key PATH -value "$HOME/ghq/github.com/golang/go/bin")"

eval "$(safepathexport -key PATH -value "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin")"
eval "$(safepathexport -key PATH -value "$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin")"
eval "$(safepathexport -key PATH -value "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin")"
eval "$(safepathexport -key PATH -value "$HOMEBREW_PREFIX/opt/gnu-time/libexec/gnubin")"
eval "$(safepathexport -key PATH -value "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin")"
eval "$(safepathexport -key PATH -value "$HOMEBREW_PREFIX/opt/make/libexec/gnubin")"

eval "$(safepathexport -key MANPATH -value "$HOMEBREW_PREFIX/opt/coreutils/libexec/man")"
eval "$(safepathexport -key MANPATH -value "$HOMEBREW_PREFIX/opt/gnu-tar/libexec/man")"
eval "$(safepathexport -key MANPATH -value "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/man")"
eval "$(safepathexport -key MANPATH -value "$HOMEBREW_PREFIX/opt/gnu-time/libexec/man")"
eval "$(safepathexport -key MANPATH -value "$HOMEBREW_PREFIX/opt/grep/libexec/man")"
eval "$(safepathexport -key MANPATH -value "$HOMEBREW_PREFIX/opt/make/libexec/man")"

eval "$(safepathexport -key FPATH -value "$HOMEBREW_PREFIX/share/zsh/site-functions" -shell)"
eval "$(safepathexport -key FPATH -value "$HOMEBREW_PREFIX/completions/zsh" -shell)"

export PURE_PROMPT_SYMBOL="$"
eval "$(sheldon source)"

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _oldlist _complete _ignored
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=1

export VULTR_API_KEY=GI2HH43CKFAIVDHJRTFIHUGCGR7NMA7AOKAQ
export GOTOOLCHAIN=local
export TF_CLI_ARGS_plan="--parallelism=30"
