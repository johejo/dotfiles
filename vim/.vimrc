set nobackup
set noswapfile
set autoread
set autoindent
set expandtab
set smartindent
set ts=2
set sw=2
set sts=2
set clipboard+=unnamedplus
syntax enable
set ignorecase
set smartcase
set number
set list
set cursorline
set showmatch
set whichwrap+=b,s,h,l,<,>,[,]
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
if exists('&ambw')
  set ambw=double
endif
filetype plugin indent on
nnoremap <C-]> g<C-]> 
