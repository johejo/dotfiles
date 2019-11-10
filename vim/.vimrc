source ~/.config/vim/base.vim

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
Plug 'mattn/sonictemplate-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'previm/previm'
Plug 'tyru/open-browser.vim'
Plug 'chr4/nginx.vim'

call plug#end()

colorscheme iceberg

" vim-lsp
if executable('gopls')
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'gopls',
      \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
      \ 'whitelist': ['go'],
      \ 'workspace_config': {'gopls': {'staticcheck': v:true}},
      \ })
  augroup END
endif
let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_text_edit_enabled = 0
nnoremap gd :LspDefinition<CR>
nnoremap H :LspHover<CR>
nnoremap <S><F2> :LspRename<CR>

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
let g:go_code_completion_enabled = 0

" vim-clap
nnoremap <silent> <C-p> :Clap history ++externalfilter=fzf<CR>
nnoremap <silent> .. :Clap files ++externalfilter=fzf<CR>

" submode.vim
call submode#enter_with('winsize', 'n', '', '<C-w><C-l>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><C-h>', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w><C-k>', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w><C-j>', '<C-w>-')
call submode#map('winsize', 'n', '', '<C-l>', '<C-w>>')
call submode#map('winsize', 'n', '', '<C-h>', '<C-w><')
call submode#map('winsize', 'n', '', '<C-k>', '<C-w>+')
call submode#map('winsize', 'n', '', '<C-j>', '<C-w>-')
