nnoremap gd :LspDefinition<CR>
nnoremap gD :tab split<CR>:LspDefinition<CR>
nnoremap gv :vsplit<CR>:LspDefinition<CR>
nnoremap gs :split<CR>:LspDefinition<CR>
nnoremap H :LspHover<CR>
nnoremap <F2> :LspRename<CR>
nnoremap gp :LspPeekDefinition<CR>

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
