lua require'nvim_lsp'.tsserver.setup{}
lua require'nvim_lsp'.gopls.setup{}
lua require'nvim_lsp'.vimls.setup{}
lua require'nvim_lsp'.tsserver.setup{}
lua require'nvim_lsp'.terraformls.setup{}
lua require'nvim_lsp'.terraformls.setup{}
lua require'nvim_lsp'.yamlls.setup{}
lua require'nvim_lsp'.jsonls.setup{}
lua require'nvim_lsp'.bashls.setup{}
lua require'nvim_lsp'.efm.setup{}

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :tab split<CR><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gv :vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gs :split<CR><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> H  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> ge <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> <F2> <cmd>lua vim.lsp.buf.rename()<CR>
