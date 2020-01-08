let g:lightline = {
  \  'component_function': {
  \    'filename': 'LightlineFilename',
  \   },
  \ }
function! LightlineFilename()
  return  expand('%') " relative
  " return expand('%:p:h') absolute
endfunction
