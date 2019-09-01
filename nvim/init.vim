if &compatible
  set nocompatible
endif

let g:python3_host_prog = expand($HOME . '/.venv/neovim/bin/python3')

let s:dein_dir = expand($XDG_CACHE_HOME . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

let s:toml = expand($XDG_CONFIG_HOME . '/nvim/dein.toml')
let s:lazy_toml = expand($XDG_CONFIG_HOME . '/nvim/dein_lazy.toml')
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:toml, s:lazy_toml])
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
set nobackup
set noswapfile
set autoread
set autoindent
set expandtab
set ts=2
set sw=2
set sts=2
set clipboard+=unnamedplus
syntax enable
set ignorecase
set smartcase
set number
set list
set cursorline
set showmatch
set whichwrap+=b,s,h,l,<,>,[,]
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
if exists('&ambw')
  set ambw=double
endif
filetype plugin indent on
nnoremap <C-]> g<C-]> 
tnoremap <Esc> <C-\><C-n>

let g:loaded_matchparen = 1
set updatetime=100
