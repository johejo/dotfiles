let g:ale_linters = {
\   'python': ['flake8'],
\   'sh': ['shellcheck'],
\   'bash': ['shellcheck'],
\   'zsh': ['shellcheck'],
\   'yaml': ['yamllint'],
\   'dockerfile': ['hadolint'],
\   'make': ['checkmake'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'markdown': ['markdownlint'],
\   'terraform': ['tflint', 'terraform'],
\   'vim': ['vint'],
\ }
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'sh': ['shfmt'],
\   'bash': ['shfmt'],
\   'zsh': ['shfmt'],
\   'terraform': ['terraform'],
\   'json': ['jq'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'yaml': ['prettier'],
\ }
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
