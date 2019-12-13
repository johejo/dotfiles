if executable('gopls')
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'go-lang',
      \ 'cmd': {server_info->['gopls']},
      \ 'whitelist': ['go'],
      \ 'workspace_config': {'gopls': {
      \     'staticcheck': v:true,
      \     'completeUnimported': v:true,
      \     'caseSensitiveCompletion': v:true,
      \     'usePlaceholders': v:true,
      \     'completionDocumentation': v:true,
      \     'watchFileChanges': v:true,
      \     'deepCompletion': v:true,
      \     'hoverKind': 'FullDocumentation',
      \   }},
      \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
    autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
    autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
  augroup END
endif
if executable('typescript-language-server')
  augroup LspTypeScript
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
      \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
      \ })
  augroup END
endif
if executable('docker-langserver')
  augroup LspDocker
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'docker-langserver',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
      \ 'whitelist': ['dockerfile'],
      \ })
  augroup END
endif
if executable('bash-language-server')
  augroup LspBash
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'bash-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
      \ 'whitelist': ['sh', 'bash', 'zsh'],
      \ })
  augroup END
endif
if executable('sql-language-server')
  augroup LspSQL
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'sql-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'sql-language-server up --method stdio']},
      \ 'whitelist': ['sql'],
      \ })
  augroup END
endif
if executable('pyls')
  augroup LspPython
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'pyls']},
      \ 'whitelist': ['python'],
      \ })
  augroup END
endif
if executable('terraform-lsp')
  augroup LspTerraform
    au!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'terraform-lsp',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'terraform-lsp']},
      \ 'whitelist': ['terraform'],
      \ })
  augroup END
endif

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

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
