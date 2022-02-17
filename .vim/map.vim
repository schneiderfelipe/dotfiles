" TODO: move this to .vimrc.mappings or something

" Make Shift-Tab 'detab' both in command and insert modes
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" Toggle NERDTree visibility with Ctrl-B
nnoremap <C-b> :NERDTreeToggle<CR>

" Fuzzy search with Ctrl-P
nnoremap <C-P> :Files<CR>

" Split the current window vertically
nnoremap <M-\> :vsplit<CR>
" Split the current window horizontally
nnoremap <M--> :split<CR>

" Toggle comment with Ctrl-/
nmap <C-_> <plug>NERDCommenterToggle
