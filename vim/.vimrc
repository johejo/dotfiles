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
Plug 'liuchengxu/vim-clap'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'previm/previm'
Plug 'tyru/open-browser.vim'
Plug 'chr4/nginx.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'hashivim/vim-terraform'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'dense-analysis/ale'

call plug#end()

set rtp+=~/repos/vim-lsp-settings

nnoremap gd :LspDefinition<CR>
nnoremap gD :tab split<CR>:LspDefinition<CR>
nnoremap gv :vsplit<CR>:LspDefinition<CR>
nnoremap gs :split<CR>:LspDefinition<CR>
nnoremap H :LspHover<CR>
nnoremap <F2> :LspRename<CR>
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_settings = {
    \ 'yaml-language-server': {
    \    'workspace_config': {
    \       'yaml': {
    \          'completion': v:true,
    \          'hover': v:true,
    \          'validate': v:true,
    \          'schemas': {
    \             'kubernetes': '/*',
    \           },
    \          'format': {
    \             'enable': v:true,
    \           }
    \        },
    \     },
    \  },
    \}
" vim-lsp
" source ~/.config/vim/lsp.vim

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
source ~/.config/vim/go.vim

" fzf.vim
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> .. :call fzf#run({'source': v:oldfiles, 'sink': 'tabe', 'options': '-m -x +s', 'down': '40%'}) <CR>

" submode.vim
source ~/.config/vim/submode.vim

" colorscheme
source ~/.config/vim/colorscheme.vim

" ALE
source ~/.config/vim/ale.vim

let g:vim_jsx_pretty_colorful_config = 1
let g:vim_jsx_pretty_enable_jsx_highlight = 1

source ~/.config/vim/base.vim
