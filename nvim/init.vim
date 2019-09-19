if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

if has('vim_starting') && &encoding !=# 'utf-8'
  set encoding=utf-8
endif

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

" Search
set ignorecase
set smartcase
set incsearch
set nohlsearch
set wrapscan

" Tab
set smarttab
set expandtab
set tabstop=2
set softtabstop=2

" Indent
set autoindent
set smartindent
set shiftround
set shiftwidth=2

" Clipboard
if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
     set clipboard& clipboard+=unnamedplus
  else
     set clipboard& clipboard+=unnamed
  endif
endif

" Enable backspace delete and newline
set backspace=indent,eol,start

" Highlight of <>
set matchpairs+=<:>

set hidden
set lazyredraw
set updatetime=500
set isfname-==
set virtualedit+=block

" Line and View
set number
set cursorline
set list
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
set laststatus=2
set cmdheight=2
set title
set showtabline=2

" Spell
set spelllang=en,cjk

" Line break
set linebreak
set showbreak=\
set breakat=\ \	;:,!?
set whichwrap+=h,l,<,>,[,],b,s,~
if exists('+breakindent')
  set breakindent
  set wrap
else
  set nowrap
endif

" No backup
set nowritebackup
set nobackup
set noswapfile
set backupdir-=.

" Key map
nnoremap <C-j> 5j
nnoremap <C-k> 5k

filetype plugin indent on
