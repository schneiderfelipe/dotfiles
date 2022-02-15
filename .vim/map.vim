" TODO: move this to .vimrc.mappings or something

" Make Shift-Tab 'detab' both in command and insert modes
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" Toggle NERDTree visibility with Ctrl-B
nnoremap <C-b> :NERDTreeToggle<CR>

" Fuzzy search with Ctrl-P
nnoremap <C-P> :FZF<CR>

" Split the current window vertically
nnoremap <C-\> :vsplit<CR>
" Split the current window horizontally
nnoremap <C-_> :split<CR>
