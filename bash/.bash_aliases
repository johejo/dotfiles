alias es='exec $SHELL'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'

alias ymd='date +%F'
alias ymdhms='date +%FT%T'
alias ymdhmst='date +%FT%T%:z'

if type git >/dev/null 2>&1; then
  alias diff='git diff --no-index'
fi

if type apt >/dev/null 2>&1 && uname -s | grep Linux >/dev/null 2>&1; then
  alias aptup='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
fi

if type snap >/dev/null 2>&1; then
  alias snaprefesh='sudo snap refresh'
fi

if type brew >/dev/null 2>&1; then
  alias brewup='brew update && brew upgrade'
fi
