if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

if has('vim_starting') && &encoding !=# 'utf-8'
  set encoding=utf-8
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
if has('clipboard')
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
nnoremap j gj
nnoremap k gk
nnoremap <C-j> 5j
nnoremap <C-k> 5k
vnoremap <C-j> 5j
vnoremap <C-k> 5k
nnoremap <C-h> 0
nnoremap <C-l> $
nnoremap <C-s> %

filetype plugin indent on
