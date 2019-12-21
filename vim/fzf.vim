nnoremap <silent> .. :FZF<CR>
nnoremap <silent> <C-p> :call fzf#run({'source': v:oldfiles, 'sink': 'tabe', 'options': '-m -x +s', 'down': '40%'}) <CR>
