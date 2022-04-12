" vim:foldmethod=marker:foldlevel=0

" GENERAL {{{

" Source a main configuration file if available.
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

" I want Vim, not vi. This has been set at this point, but I want to
" be *very* explicit.
set nocompatible

" Not required by Neovim, but useful in Vim.
" It also ensures that the minimap works correctly.
set encoding=UTF-8

" Vim and Neovim share the same configuration file.
let data_dir = expand('~/.vim')

" Hard mode settings.
let g:hardtime_default_on = 1
let g:hardtime_maxcount = 50
let g:hardtime_allow_different_key = 1
let g:hardtime_showmsg = 1

" }}}
if !exists('g:vscode')
" USER INTERFACE {{{

" Show line numbers.
" This, together with the vim-numbertoggle plugin, will relativize line
" numbers in appropriate circumstances.
set number

" Find the current line quickly.
set cursorline

" Always report changed lines.
set report=0

" The fish shell is not POSIX compliant and unexpectedly breaks things that use
" 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/sh
endif

" Minimap settings
let g:minimap_width = 8
let g:minimap_highlight_range = 1
let g:minimap_highlight_search = 1
let g:minimap_git_colors = 1

" Commenting settings
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCommentEmptyLines = 1
let g:NERDCommentWholeLinesInVMode = 2

" More natural splitting
set splitbelow  " Open new windows below current one.
set splitright  " Open new windows right of current one.

" Allow using the mouse in all modes
set mouse=a

" Allow inserting LaTeX symbols as Unicode everywhere, courtesy of the Julia
" Vim plugin.
let g:latex_to_unicode_file_types = ".*"

" Syntax highlighting for Markdown fenced code blocks
" MISSING:
" - Svelte
" - Jupyter notebooks?
let g:markdown_fenced_languages = [
  \ 'bash',
  \ 'console=sh',
  \ 'sh',
  \ 'shell=sh',
  \ 'zsh',
  \ 'html',
  \ 'javascript',
  \ 'typescript',
  \ 'css',
  \ 'json',
  \ 'c',
  \ 'go',
  \ 'rust',
  \ 'julia',
  \ 'python',
  \ 'vim',
  \ 'vimscript=vim',
\ ]
let g:markdown_syntax_conceal = 0

" }}}
" THEME {{{

" Emit 24-bit colors
if has('termguicolors')
  set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic = 1

" Use Monokai colorscheme
autocmd VimEnter * colorscheme sonokai

" }}}
" STATUS LINE {{{

" Always show the status line.
set laststatus=2

" Show as much as possible in the status line.
set display=lastline

" Show the current mode in the status line.
set showmode

" Show the already typed keys when more are expected.
set showcmd

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

" Use spaces instead of tabs.
set expandtab

" Number of visual spaces per tab character.
set tabstop=4

" Number of spaces per tab character when editing.
set softtabstop=4

" Number of spaces to shift when indenting.
set shiftwidth=4

" Indent to next multiple of shiftwidth.
set shiftround

" Use smart case during searches.
set ignorecase
set smartcase

" Wrapping settings.
" This wraps long lines in all text modes and shows a visual
" indicator.
set textwidth=79
autocmd VimEnter *
  \ set formatoptions+=t |
  \ set formatoptions-=l
set colorcolumn=+1

" Indentation guides settings
" let g:indent_blankline_show_end_of_line = v:true
" let g:indent_blankline_space_char_blankline = " "
" let g:indent_blankline_show_current_context = v:true
" let g:indent_blankline_show_current_context_start = v:true

" Show non-printable characters.
" set list
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:├─┤,space:·,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:|-|,space:.,extends:>,precedes:<,nbsp:.'
endif

" }}}
" TEMPORARY FILES {{{

" Keep a backup across sessions by storing it in a file.
set backup
let &backupdir = data_dir . '/backup//'
" Create directory if missing
if !isdirectory(&backupdir)
  silent execute '!mkdir -p ' . &backupdir
endif

" Never skip backups.
set backupskip=


" Keep swap files around.
let &directory = data_dir . '/swap//'
" Create directory if missing
if !isdirectory(&directory)
  silent execute '!mkdir -p ' . &directory
endif


" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  set undofile
  let &undodir = data_dir . '/undo//'
  " Create directory if missing
  if !isdirectory(&undodir)
    silent execute '!mkdir -p ' . &undodir
  endif
endif

" }}}
" ASYNCHRONOUS LINT ENGINE {{{

" As-you-type autocomplete.
set completeopt=preview,menu,menuone,noselect,noinsert
let g:ale_completion_enabled = 1

" Fixers.
let g:ale_fixers = {
  \ 'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace'],
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }

" Fix on save.
let g:ale_fix_on_save = 1

" Install the latest rust-analyzer if missing.
if !executable('rust-analyzer')
  silent execute '!mkdir -p ' . '~/.local/bin'
  silent execute '!curl -L
    \ https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz
    \ | gunzip -c - > ~/.local/bin/rust-analyzer'
  silent execute '!chmod +x ~/.local/bin/rust-analyzer'
end

" Linters.
let g:ale_linters = {
  \ 'rust': ['rls'],
\ }

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

  " Vim hard mode
  Plug 'takac/vim-hardtime'

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
  " Set tmux's status line to match Vim's
  Plug 'edkolev/tmuxline.vim'

  " Monokai-inspired colorscheme
  Plug 'sainnhe/sonokai'

  " Asynchronous lint engine
  Plug 'dense-analysis/ale'
  " Latest version of the official Rust language support
  Plug 'rust-lang/rust.vim'
  " Latest version of the official Julia language support
  Plug 'JuliaEditorSupport/julia-vim'

  " Latest version of the default Vim Markdown runtime files
  Plug 'tpope/vim-markdown'

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

" vim-plug already executes the following commands, but let's be *very*
" explicit again. This is required after plugin management for most plugin
" managers anyway.
syntax on  " Enable syntax highlighting.
filetype plugin indent on  " Load plugins according to detected filetype.

" }}}
endif
