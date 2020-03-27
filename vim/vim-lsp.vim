nmap gd <Plug>(lsp-definition)
nmap gD :tab split<CR><Plug>(lsp-definition)
nmap gv :vsplit<CR><Plug>(lsp-definition)
nmap gs :split<CR><Plug>(lsp-definition)
nmap H <Plug>(lsp-hover)
nmap <F2> <Plug>(lsp-rename)
nmap gp <Plug>(lsp-peek-definition)

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

let g:lsp_diagnostics_float_cursor = 1

let g:lsp_settings = {
\  'efm-langserver': {'disabled': v:false},
\}

let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']

let g:efm_langserver_settings#debug = 1
