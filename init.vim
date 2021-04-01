call plug#begin(stdpath('data') . '/plugged')

Plug 'srcery-colors/srcery-vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-json', 'coc-yaml', 'coc-go', 'coc-vimlsp', 'coc-tsserver', 'coc-prettier', 'coc-eslint', 'coc-diagnostic', 'coc-sh', 'coc-html', 'coc-snippets']

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sheerun/vim-polyglot'

Plug 'kana/vim-submode'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

Plug 'windwp/nvim-autopairs'

call plug#end()

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

set nobackup
set nowritebackup
set noswapfile
set autoread

set tabstop=2
set softtabstop=2
set expandtab
set breakindent
set smartindent
set shiftwidth=2

set number
set cursorline
set ignorecase
set signcolumn=yes
set smartcase
set nohlsearch

set nowrap
set backspace=indent,eol,start
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
set whichwrap=b,s,h,l,<,>,[,],~

set termguicolors
set clipboard=unnamedplus

lua <<EOF
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {'go'},
  highlight = {
    enable = true,
  },
}

require('nvim-autopairs').setup()
EOF

call submode#enter_with('winsize', 'n', '', '<C-w><C-l>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><C-h>', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w><C-k>', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w><C-j>', '<C-w>-')
call submode#map('winsize', 'n', '', '<C-l>', '<C-w>>')
call submode#map('winsize', 'n', '', '<C-h>', '<C-w><')
call submode#map('winsize', 'n', '', '<C-k>', '<C-w>+')
call submode#map('winsize', 'n', '', '<C-j>', '<C-w>-')

augroup MyCocCmd
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

nnoremap <silent>gd <cmd>call CocAction('jumpDefinition')<CR>
nnoremap <silent>H <cmd>call CocAction('doHover')<CR>
nnoremap <silent><C-q> <cmd>call CocAction('jumpReferences')<CR>
nnoremap <silent><Space>rn <cmd>call CocActionAsync('rename')<CR>

function! s:go_imports() abort
  call CocAction('format')
  :CocCommand editor.action.organizeImport
endfunction

augroup MyGoCmd
  autocmd BufWritePre *.go silent call s:go_imports()
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

function! LightlineFilename()
  return expand('%:p')
endfunction

let g:lightline = {
\ 'colorscheme': 'srcery',
\ 'component_function': {
\   'filename': 'LightlineFilename',
\ }
\}

colorscheme srcery

noremap j gj
noremap gj j
noremap k gk
noremap gk k

noremap <C-h> 0
noremap <C-j> 5j
noremap <C-k> 5k
noremap <C-l> $

nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
nnoremap Y y$

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

nnoremap .. <cmd>Files<CR>
nnoremap <Space>g <cmd>Rg .<CR>
nnoremap <C-p> <cmd>History<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
