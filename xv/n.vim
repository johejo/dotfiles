call plug#begin(stdpath('data') . '/plugged')

Plug 'neovim/nvim-lsp'
Plug 'cohama/lexima.vim'

call plug#end()

augroup MyGoAutoCmd
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

lua require'nvim_lsp'.gopls.setup{}
