nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :tab split<CR><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gv :vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gs :split<CR><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> H  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD <cmd>lua vim.lsp.buf.type_definition()<CR>
