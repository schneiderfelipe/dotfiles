" Source a main configuration file if available
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

" vim and neovim share the same configuration
let data_dir = expand('~/.vim')


" Allow using the mouse in all modes
set mouse=a

" Make Shift-Tab 'detab' both in command and insert modes
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" Natural splitting
set splitbelow
set splitright

" Show line numbers.
" This, together with the vim-numbertoggle plugin, will relativize line
" numbers in appropriate circumstances.
set number

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  set undofile
  let &undodir = data_dir . '/undodir'
  " Create directory if missing
  if !isdirectory(&undodir)
    silent execute '!mkdir -p ' . &undodir
  endif
endif


" Path to vim-plug
let autoload_plug = data_dir . '/autoload/plug.vim'

" Automatically install vim-plug if missing
if empty(glob(autoload_plug))
  silent execute '!rm ' . autoload_plug
  silent execute '!curl -fLo ' . autoload_plug . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" The list of vim-plug plugins.
" It also executes the following commands:
"
" ```
" syntax on
" filetype plugin indent on
" ```
call plug#begin(data_dir . '/plugged')
  " Provide help for vim-plug itself.
  Plug 'junegunn/vim-plug'

  " Sensible defaults
  Plug 'tpope/vim-sensible'

  " Restore sessions
  Plug 'tpope/vim-obsession'
  " Remember positions
  Plug 'farmergreg/vim-lastplace'

  " Toggle between hybrid and absolute line numbers automatically
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  " Show git markers
  Plug 'airblade/vim-gitgutter'
  " Integration with tmux
  Plug 'christoomey/vim-tmux-navigator'
  " Statusline
  Plug 'nvim-lualine/lualine.nvim'

  " GitHub copilot
  Plug 'github/copilot.vim'

  " Automatic indentation detection
  Plug 'tpope/vim-sleuth'
  " Indent guides
  Plug 'lukas-reineke/indent-blankline.nvim'

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
  silent execute '!ln -s -t ' . data_dir . '/autoload/ ' . data_dir . '/plugged/vim-plug/plug.vim'
endif


" Emit 24-bit colors
set termguicolors

" Use GitHub colorscheme
colorscheme github_dark
if has('nvim')
lua << EOF
  require('lualine').setup {
    options = {
      theme = 'github',
    }
  }
EOF
endif
