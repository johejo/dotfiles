call plug#begin(stdpath('data') . '/plugged')

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'cohama/lexima.vim'

call plug#end()

augroup MyGoAutoCmd
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END
