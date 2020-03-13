" dein
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_path = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_path)
  execute '!git clone https://github.com/Shougo/dein.vim' shellescape(s:dein_path)
endif

let s:python3_venv = expand('~/.config/vim/venv')
let g:python3_host_prog = s:python3_venv . '/bin/python3'
if !isdirectory(s:python3_venv) && executable('python3')
  execute '!python3 -m venv' s:python3_venv
  execute '!' . g:python3_host_prog . ' -m pip install -U pip'
  execute '!' . g:python3_host_prog . ' -m pip install -U pynvim'
endif

let &runtimepath .= ',' . s:dein_path
if dein#load_state(s:dein_dir)
  let s:dein_toml = '~/.config/vim/dein.toml'
  let s:dein_lazy_toml = '~/.config/vim/dein_lazy.toml'
  let s:dein_nvim_toml = '~/.config/nvim/dein_nvim.toml'
  call dein#begin(s:dein_dir, [s:dein_toml, s:dein_lazy_toml, s:dein_nvim_toml])
  call dein#load_toml(s:dein_toml, {'lazy': 0})
  call dein#load_toml(s:dein_lazy_toml, {'lazy' : 1})
  if has("nvim")
    call dein#load_toml(s:dein_nvim_toml, {'lazy' : 1})
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
