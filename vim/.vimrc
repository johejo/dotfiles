set nobackup
set noswapfile
set autoread
set autoindent
set expandtab
set smartindent
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

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(expand('~/./plugged'))

Plug 'lifepillar/vim-solarized8'

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
