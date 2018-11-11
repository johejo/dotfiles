alias sp='source ~/.bashrc'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'

alias ymd='date +%F'
alias ymdhms='date +%FT%T'
alias ymdhmst='date +%FT%T%:z'

function check_operating_system() {
  uname -a | grep $1 > /dev/null 2>&1
  echo $?
}

is_darwin=`check_operating_system 'Darwin'`
is_ubuntu=`check_operating_system 'Ubuntu'`
is_linux=`check_operating_system 'Linux'`

if type git > /dev/null 2>&1; then
  alias diff='git diff --no-index'
fi

if type nvim > /dev/null 2>&1; then
  alias vim=nvim
fi

if [ $is_ubuntu = 0 ]; then
  alias aptup='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
fi

if type snap > /dev/null 2>&1; then
  alias snapup='snap refresh'
fi

if type brew > /dev/null 2>&1; then
  alias brewup='brew update && brew upgrade'
fi

if type yarn > /dev/null 2>&1; then
  alias npm='yarn'
fi
