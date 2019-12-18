let g:lsp_signs_enabled = 1
let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlight_references_enabled = 0
let g:lsp_text_edit_enabled = 0

function! s:on_lsp_buffer_enabled()
  setlocal signcolumn=yes
  setlocal omnifunc=lsp#complete
  nmap gd <plug>(lsp-definition)
  nmap ,n <plug>(lsp-next-error)
  nmap ,p <plug>(lsp-previous-error)
  nmap <F2> <plug>(lsp-rename)
  nmap gD :tab split<CR> <plug>(lsp-definition)
  nmap gv :vsplit<CR> <plug>(lsp-definition)
  nmap gs :split<CR> <plug>(lsp-definition)
  nmap H <plug>(lsp-hover)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_server_init call s:on_lsp_buffer_enabled()
augroup END

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
