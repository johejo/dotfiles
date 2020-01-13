" dein
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_path = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_path)
  execute '!git clone --depth=1 https://github.com/Shougo/dein.vim' s:dein_path
endif

let &runtimepath .= ',' . s:dein_path
if dein#load_state(s:dein_dir)
  let s:dein_toml = '~/.config/vim/dein.toml'
  let s:dein_lazy_toml = '~/.config/vim/dein_lazy.toml'
  call dein#begin(s:dein_dir, [s:dein_toml, s:dein_lazy_toml])
  call dein#load_toml(s:dein_toml, {'lazy': 0})
  call dein#load_toml(s:dein_lazy_toml, {'lazy' : 1})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" python3
let s:python3_venv = expand('~/.config/vim/venv')
let g:python3_host_prog = s:python3_venv . '/bin/python3'
if !isdirectory(s:python3_venv) && executable('python3')
  execute '!python3 -m venv' s:python3_venv
  execute '!' . g:python3_host_prog . ' -m pip install -U pip'
  execute '!' . g:python3_host_prog . ' -m pip install -U pynvim'
endif

colorscheme iceberg

" search
set ignorecase
set smartcase
set tabstop=2
set softtabstop=2
set incsearch
set nohlsearch
set wrapscan

" tab
set smarttab
set expandtab

" indent
set shiftwidth=2
set shiftround
set autoindent
set smartindent
set modeline

" clipboard
if has('clipboard') && has('unnamedplus')
  set clipboard&
  set clipboard^=unnamedplus
endif

" fold
set foldenable
" set foldmethod=indent

" view
set number
set cursorline
set list
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
set laststatus=2
set cmdheight=2
set title
set showtabline=2

" line break
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

" backup
set nowritebackup
set nobackup
set noswapfile

" others
set backspace=indent,eol,start
set matchpairs+=<:>
set hidden
set lazyredraw
set completeopt-=preview

" key mappings
nnoremap j gj
nnoremap k gk
nnoremap <C-j> 5j
nnoremap <C-k> 5k
vnoremap <C-j> 5j
vnoremap <C-k> 5k
nnoremap <C-h> 0
nnoremap <C-l> $
nnoremap <C-s> %
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
nnoremap <C-c> <Esc>
snoremap <C-C> <Esc>
vnoremap <C-h> 0
vnoremap <C-l> $
tnoremap <C-[> <C-\><C-n>

filetype plugin indent on
syntax enable
