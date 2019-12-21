nnoremap <silent> <C-p> :Denite file/old<CR>
nnoremap <silent> .. :Denite file/rec<CR>
nnoremap <silent> db :Denite buffer<CR>
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> t denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplit')
endfunction

call denite#custom#source('file/old', 'converters',
    \ ['converter/abbr_word', 'converter/relative_abbr', 'converter/relative_word'])
call denite#custom#source('tag', 'matchers', ['matcher/substring'])
call denite#custom#source('file/rec', 'matchers',
    \ ['matcher/fruzzy', 'converter/abbr_word'])

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
    \ ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7
call denite#custom#option('default', {
    \ 'highlight_filter_background': 'CursorLine',
    \ 'source_names': 'short',
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ })
