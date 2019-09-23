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
nnoremap j gj
nnoremap k gk
nnoremap <C-j> 5j
nnoremap <C-k> 5k
nnoremap <C-h> 0
nnoremap <C-l> $

filetype plugin indent on

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(expand('~/./plugged'))

Plug 'kana/vim-submode'
Plug 'itchyny/lightline.vim'
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

colorscheme iceberg

" vim-lsp
if executable('gopls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'gopls',
    \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
    \ 'whitelist': ['go'],
    \ })
  autocmd BufWritePre *.go LspDocumentFormatSync
endif
if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
  endif
let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_text_edit_enabled = 0

" asynccomplete.vim
let g:asyncomplete_auto_popup = 1
set completeopt=menuone,noinsert,noselect,preview
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

" vim-go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
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
let g:go_def_mapping_enabled = 0

" fzf.vim
nnoremap <silent> <C-p> :FZF<CR>

" submode.vim
call submode#enter_with('winsize', 'n', '', '<C-w><C-l>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><C-h>', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w><C-k>', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w><C-j>', '<C-w>-')
call submode#map('winsize', 'n', '', '<C-l>', '<C-w>>')
call submode#map('winsize', 'n', '', '<C-h>', '<C-w><')
call submode#map('winsize', 'n', '', '<C-k>', '<C-w>+')
call submode#map('winsize', 'n', '', '<C-j>', '<C-w>-')
