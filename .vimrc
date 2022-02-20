" vim:foldmethod=marker:foldlevel=0

" GENERAL {{{

" Source a main configuration file if available.
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

" Not required by Neovim, but useful in Vim.
" It also ensures that the minimap works correctly.
set encoding=UTF-8

" vim-plug already executes the following commands, but who knows.
syntax on
filetype plugin indent on

" Vim and Neovim share the same configuration file.
let data_dir = expand('~/.vim')

" }}}
" USER INTERFACE {{{

" Show line numbers.
" This, together with the vim-numbertoggle plugin, will relativize line
" numbers in appropriate circumstances.
set number

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
  \ exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Minimap settings
let g:minimap_width = 8
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_range = 1
let g:minimap_highlight_search = 1
let g:minimap_git_colors = 1

" Commenting settings
" let g:NERDDefaultAlign = 'start'
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCommentEmptyLines = 1
let g:NERDCommentWholeLinesInVMode = 2

" Natural splitting
set splitbelow
set splitright

" Allow using the mouse in all modes
set mouse=a

" }}}
" THEME {{{

" Emit 24-bit colors
set termguicolors

" Use Monokai colorscheme
autocmd VimEnter * colorscheme sonokai

" }}}
" STATUS LINE {{{

" Set the airline status line theme.
let g:airline_theme = 'sonokai'

" Enable a smarter tab line.
let g:airline#extensions#tabline#enabled = 1

" Generate a tmuxline status line to be loaded later by tmux.
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tmuxline#snapshot_file = '~/.tmuxline'

" Select tmuxline preset.
let g:tmuxline_preset = 'full'

" No separators in tmuxline status line. This should match vim-airline.
let g:tmuxline_powerline_separators = 0

" }}}
" SPACES AND TABS {{{

" Number of visual spaces per tab character.
set tabstop=4

" Number of spaces per tab character when editing.
set softtabstop=4

" Number of spaces to shift when indenting.
set shiftwidth=4

" Use spaces instead of tabs.
set expandtab

" Wrapping settings.
" This wraps long lines in all text modes and shows a visual
" indicator.
set textwidth=79
autocmd VimEnter *
  \ set formatoptions+=t |
  \ set formatoptions-=l
set colorcolumn=80

" Indentation guides settings
" let g:indent_blankline_show_end_of_line = v:true
" let g:indent_blankline_space_char_blankline = " "
" let g:indent_blankline_show_current_context = v:true
" let g:indent_blankline_show_current_context_start = v:true

" Show whitespace characters
set listchars=tab:├─┤,space:·
set list

" Remove trailing whitespace and blank lines at the end of the file
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  keeppatterns v/\_s*\S/d
  call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
" Run the function when the file is saved
autocmd BufWritePre * if !&binary && &ft !=# 'mail'
  \|   call TrimWhitespace()
  \| endif

" Make Shift-Tab 'detab' both in command and insert modes
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" }}}
" UNDO {{{

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  set undofile
  let &undodir = data_dir . '/undodir'
  " Create directory if missing
  if !isdirectory(&undodir)
    silent execute '!mkdir -p ' . &undodir
  endif
endif

" }}}
" KEYBINDINGS {{{

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

" }}}
" PLUGIN MANAGEMENT {{{

" Path to vim-plug
let autoload_plug = data_dir . '/autoload/plug.vim'

" Automatically install vim-plug if missing
if empty(glob(autoload_plug))
  silent execute '!rm ' . autoload_plug
  silent execute '!curl -fLo ' . autoload_plug .
    \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" The list of vim-plug plugins.
call plug#begin(data_dir . '/plugged')
  " Provide help for vim-plug itself.
  Plug 'junegunn/vim-plug'

  " Sensible defaults
  Plug 'tpope/vim-sensible'

  " Restore sessions
  Plug 'tpope/vim-obsession'
  " Remember positions
  Plug 'farmergreg/vim-lastplace'

  " Illuminate the current word
  Plug 'RRethy/vim-illuminate'
  " Toggle between hybrid and absolute line numbers automatically
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  " Show git markers
  Plug 'airblade/vim-gitgutter'
  " Integration with tmux
  Plug 'christoomey/vim-tmux-navigator'
  " Minimap
  Plug 'wfxr/minimap.vim', {'do': ':!cargo install code-minimap'}
  " File explorer
  Plug 'preservim/nerdtree'

  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Interactive coding scratchpad
  Plug 'metakirby5/codi.vim'
  " GitHub copilot
  Plug 'github/copilot.vim'

  " Commenting
  Plug 'preservim/nerdcommenter'

  " Automatic indentation detection
  Plug 'tpope/vim-sleuth'
  " Indent guides
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Set tmux's status line to match vim's
  Plug 'edkolev/tmuxline.vim'

  " Monokai-inspired colorscheme
  Plug 'sainnhe/sonokai'

  " Icons.
  " This should be the last plugin to be loaded.
  Plug 'ryanoasis/vim-devicons'
call plug#end()

" Ensure autoload/plug.vim is a symlink to plugged/vim-plug/plug.vim.
" This should come after plug#end().
if resolve(autoload_plug) == autoload_plug
  silent execute '!rm ' . autoload_plug
  silent execute '!ln -s -t ' . data_dir . '/autoload/ '
    \ . data_dir . '/plugged/vim-plug/plug.vim'
endif

" }}}
