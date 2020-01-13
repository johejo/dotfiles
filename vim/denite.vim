call denite#custom#source('file/old', 'converters',
    \ ['converter/abbr_word', 'converter/relative_abbr', 'converter/relative_word'])
call denite#custom#source('tag', 'matchers', ['matcher/substring'])

if has("nvim")
  call denite#custom#source('file/rec', 'matchers',
      \ ['matcher/fruzzy', 'converter/abbr_word', 'matcher/ignore_globs'])
endif

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
    \ ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', 'node_modules/'])
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
