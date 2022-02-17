" Source a main configuration file if available
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

" Not required by Neovim, but useful in Vim.
" It also ensures that the minimap works correctly.
set encoding=UTF-8


" vim and neovim share the same configuration
let data_dir = expand('~/.vim')

" Keybindings are defined in a separate file.
let map_file = data_dir . '/map.vim'
if filereadable(map_file)
  " Load the keybindings when Vim is started.
  autocmd VimEnter * silent execute 'source ' . map_file
endif

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  set undofile
  let &undodir = data_dir . '/undodir'
  " Create directory if missing
  if !isdirectory(&undodir)
    silent execute '!mkdir -p ' . &undodir
  endif
endif

" Wrapping settings.
" This wraps long lines in all text modes and shows a visual
" indicator.
set textwidth=79
autocmd VimEnter *
  \ set formatoptions+=t |
  \ set formatoptions-=l
set colorcolumn=80

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
  \ exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Generate a tmuxline status bar to be loaded by tmux.
autocmd VimEnter * execute ':Tmuxline' |
  \ execute ':TmuxlineSnapshot ~/.tmuxline'

" Minimap settings
let g:minimap_width = 8
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_range = 1
let g:minimap_highlight_search = 1
let g:minimap_git_colors = 1

" Commenting settings
let g:NERDDefaultAlign = 'start'
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCommentEmptyLines = 1
let g:NERDCommentWholeLinesInVMode = 2

" Show whitespace characters
set listchars=tab:├─┤,eol:↵,space:·
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

" Indentation guides settings
let g:indent_blankline_show_end_of_line = v:true
let g:indent_blankline_space_char_blankline = " "
" let g:indent_blankline_show_current_context = v:true
" let g:indent_blankline_show_current_context_start = v:true

" Natural splitting
set splitbelow
set splitright

" Show line numbers.
" This, together with the vim-numbertoggle plugin, will relativize line
" numbers in appropriate circumstances.
set number

" Allow using the mouse in all modes
set mouse=a


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
  " Statusline
  Plug 'nvim-lualine/lualine.nvim'
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

  " Set tmux's statusline to match vim's
  Plug 'edkolev/tmuxline.vim'

  " GitHub color scheme
  Plug 'projekt0n/github-nvim-theme'
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

" vim-plug already executes the following commands, but who knows.
syntax on
filetype plugin indent on


" Emit 24-bit colors
set termguicolors

" Use GitHub colorscheme
colorscheme github_dark

" Configurations requiring lua
if has('nvim')
lua << EOF
  -- GitHub colorscheme settings for lualine
  require('lualine').setup {
    options = {
      theme = 'github',
    }
  }
EOF
endif
