let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_text_edit_enabled = 0

nnoremap gd :LspDefinition<CR>
nnoremap gD :tab split<CR>:LspDefinition<CR>
nnoremap gv :vsplit<CR>:LspDefinition<CR>
nnoremap gs :split<CR>:LspDefinition<CR>
nnoremap H :LspHover<CR>
nnoremap <F2> :LspRename<CR>
set completeopt-=preview

let g:lsp_settings = {
  \  'typescript-language-server': {
  \     'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact']}
  \}
