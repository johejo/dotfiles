call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-submode'

Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'
Plug 'ujihisa/neco-look'
Plug 'nvim-lua/lsp-status.nvim'

Plug 'Shougo/deol.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/gina.vim'
Plug 'lambdalisue/vim-findent'
Plug 'cohama/lexima.vim'

Plug 'mattn/vim-goimports', { 'for': 'go' }
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }

Plug 'tyru/open-browser.vim'
Plug 'previm/previm', { 'for': 'markdown' }

Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sheerun/vim-polyglot'
Plug 'gruvbox-community/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'vim-scripts/twilight'
Plug 'jonathanfilip/vim-lucius'
Plug 'jpo/vim-railscasts-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/Wombat'
Plug 'tomasr/molokai'
Plug 'vim-scripts/rdark'
Plug 'lifepillar/vim-solarized8'
Plug 'ghifarit53/tokyonight-vim'

call plug#end()

call submode#enter_with('winsize', 'n', '', '<C-w><C-l>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><C-h>', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w><C-k>', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w><C-j>', '<C-w>-')
call submode#map('winsize', 'n', '', '<C-l>', '<C-w>>')
call submode#map('winsize', 'n', '', '<C-h>', '<C-w><')
call submode#map('winsize', 'n', '', '<C-k>', '<C-w>+')
call submode#map('winsize', 'n', '', '<C-j>', '<C-w>-')

lua <<EOF
require'nvim_lsp'.gopls.setup{
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false
        }
      }
    }
  },
  init_options = {
    usePlaceholders = false,
  }
}
require'nvim_lsp'.yamlls.setup{}
require'nvim_lsp'.jsonls.setup{}
require'nvim_lsp'.terraformls.setup{}
require'nvim_lsp'.vimls.setup{}
require'nvim_lsp'.efm.setup{}
require'nvim_lsp'.bashls.setup{}

require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true,
  }
}
EOF

let g:diagnostic_enable_virtual_text = 1
"let g:diagnostic_insert_delay = 1

let g:lightline = {
\ 'colorscheme': 'solarized',
\ 'component_function': {
\   'filename': 'LightlineFilename'
\ }
\}
function! LightlineFilename()
  return expand('%:p')
endfunction

let g:terraform_fmt_on_save=1

augroup MyAutoCmd
  autocmd!
  autocmd BufEnter * lua require'diagnostic'.on_attach()
  "autocmd BufEnter * :TSBufEnable highlight
  autocmd BufWritePre *.go,*.json,*.yaml,*.sh lua vim.lsp.buf.formatting_sync()
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
augroup END

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-q> <cmd>lua vim.lsp.buf.hover()<CR>
command! LspCodeAction lua vim.lsp.buf.code_action()<CR>
command! LspRename lua vim.lsp.buf.rename()<CR>

let g:deoplete#enable_at_startup = 1

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

set clipboard=unnamedplus
set backspace=indent,eol,start

set autoread
set hidden
set lazyredraw
set updatetime=500

" Line and View
set number
set cursorline
set list
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
set laststatus=2
set cmdheight=2
set title
set showtabline=2
set nostartofline

" No backup
set nowritebackup
set nobackup
set noswapfile

set completeopt=menu,menuone,noselect
set fileformat=unix

set termguicolors
colorscheme tokyonight
