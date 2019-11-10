" Python venv
let g:python3_host_prog = expand($HOME . '/.venv/neovim/bin/python3')

" Load dein
let s:dein_dir = expand($XDG_CACHE_HOME . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

let &runtimepath = s:dein_repo_dir .",". &runtimepath

let s:dein_toml = expand($XDG_CONFIG_HOME . '/nvim/dein.toml')
let s:dein_lazy_toml = expand($XDG_CONFIG_HOME . '/nvim/dein_lazy.toml')
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:dein_toml, s:dein_lazy_toml])
  call dein#load_toml(s:dein_toml,      {'lazy': 0})
  call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

source ~/.config/vim/base.vim
