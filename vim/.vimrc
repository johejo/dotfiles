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

filetype plugin indent on

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(expand('~/./plugged'))

Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
set completeopt+=preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
if executable('gopls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'gopls',
    \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
    \ 'whitelist': ['go'],
    \ })
  autocmd BufWritePre *.go LspDocumentFormatSync
endif

call plug#end()

colorscheme jellybeans

let g:go_highright_functions = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_addtags_transform = "camelcase"
