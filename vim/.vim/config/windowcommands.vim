"open file under cursor in vertical window
map <C-f> :vs <cfile><cr>

"open new terminal in vertical mode
command! TV execute "vs |term"

"open new terminal in horizontal mode
command! TH execute "split|term"

"when click esq terminal enters in vim mode
tnoremap <Esc> <C-\><C-n>

"set background to dark, for transparent terminals :)
nnoremap <C-K> :set background=dark <CR>

"open file under cursor in same buffer
:map gf :e <cfile><cr>

"set background as none for transparente terminals :)
nnoremap <C-l> :hi Normal guibg=NONE ctermbg=NONE <CR>
