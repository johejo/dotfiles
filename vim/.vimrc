" vim-plug
if has('nvim')
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

let g:python3_host_prog = expand($HOME . '/.venv/neovim/bin/python3')

if has('nvim')
  call plug#begin(expand('~/.config/nvim/plugged'))
else
  call plug#begin(expand('~/.vim/plugged'))
endif

" common
Plug 'kana/vim-submode'
Plug 'itchyny/lightline.vim'
Plug 'cocopon/iceberg.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 't9md/vim-choosewin'
Plug 'Shougo/context_filetype.vim'

" LSP
if has('nvim')
  Plug 'neovim/nvim-lsp'
else
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
endif

" complete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/deoplete-lsp', { 'do': ':UpdateRemotePlugins' }
  Plug 'ncm2/float-preview.nvim'
else
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/asyncomplete-file.vim'
  Plug 'prabirshrestha/asyncomplete-buffer.vim'
endif

" fuzzy finder
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
else
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
endif

" terminal
Plug 'Shougo/deol.nvim'

" snippets
if has('python3')
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  if !has('nvim')
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
  endif
endif

" file explorer
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" code formatter, linter
Plug 'dense-analysis/ale'

" markdown
Plug 'godlygeek/tabular', { 'for': ['markdown'] }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
Plug 'previm/previm', { 'for': ['markdown'] }
Plug 'tyru/open-browser.vim', { 'for': ['markdown'] }

" javascript, typescript
Plug 'pangloss/vim-javascript',
      \ { 'for': ['javascript', 'javascript.jsx', 'javascriptresct', 'typescript', 'typescript.tsx', 'typescriptreact'] }
Plug 'HerringtonDarkholme/yats.vim',
      \ { 'for': ['typescript', 'typescript.tsx', 'typescriptreact'] }
Plug 'maxmellon/vim-jsx-pretty',
      \ { 'for': ['javascript.jsx', 'javascriptresct', 'typescript.tsx', 'typescriptreact'] }

" Go
Plug 'mattn/vim-goimports', { 'for': ['go'] }

" Terraform
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }

" Dockerfile
Plug 'ekalinin/Dockerfile.vim', { 'for': ['dockerfile', 'yaml'] }

" Kubernetes
Plug 'andrewstuart/vim-kubernetes', { 'for': ['yaml'] }

" other
Plug 'chr4/nginx.vim', { 'for': ['nginx'] }
Plug 'chrisbra/vim-zsh', { 'for': ['zsh'] }
Plug 'cespare/vim-toml', { 'for': ['toml'] }

call plug#end()

source ~/.config/vim/submode.vim
source ~/.config/vim/colorscheme.vim

if has('nvim')
  source ~/.config/vim/defx.vim
  source ~/.config/vim/deol.vim
  source ~/.config/vim/deoplete.vim
  source ~/.config/vim/denite.vim
  :luafile ~/.config/nvim/init.lua
else
  source ~/.config/vim/fzf.vim
  source ~/.config/vim/lsp.vim
  source ~/.config/vim/asyncomplete.vim
endif

if has('python3')
  source ~/.config/vim/ultisnips.vim
endif

source ~/.config/vim/ale.vim

augroup MyAutoCmd
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

source ~/.config/vim/base.vim
