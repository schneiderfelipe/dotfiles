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
set encoding=UTF-8

" Vim and Neovim share the same configuration file.
let data_dir = expand('~/.vim')

" }}}
" if !exists('g:vscode')
" USER INTERFACE {{{

" Show line numbers.
" This, together with the vim-numbertoggle plugin, will relativize line
" numbers in appropriate circumstances.
set number

" Find the current line quickly.
set cursorline

" Always report changed lines.
set report=0

" Faster updates
set updatetime=100

" The fish shell is not POSIX compliant and unexpectedly breaks things that use
" 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/sh
endif

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

" }}}
" WIKI {{{

let g:vimwiki_list = [{'path': '~/Dropbox/notes',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

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
  execute '!mkdir -p ' . &backupdir
endif

" Never skip backups.
set backupskip=


" Keep swap files around.
let &directory = data_dir . '/swap//'
" Create directory if missing
if !isdirectory(&directory)
  execute '!mkdir -p ' . &directory
endif


" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  set undofile
  let &undodir = data_dir . '/undo//'
  " Create directory if missing
  if !isdirectory(&undodir)
    execute '!mkdir -p ' . &undodir
  endif
endif

" }}}
" ASYNCHRONOUS LINT ENGINE {{{

" As-you-type autocomplete.
set completeopt=preview,menu,menuone,noselect,noinsert
let g:ale_completion_enabled = 1

" Fix on save.
let g:ale_fix_on_save = 1

" Install the latest rust-analyzer if missing.
if !executable('rust-analyzer')
  execute '!mkdir -p ' . '~/.local/bin'
  execute '!curl -L
    \ https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz
    \ | gunzip -c - > ~/.local/bin/rust-analyzer'
  execute '!chmod +x ~/.local/bin/rust-analyzer'
end

" Optional static typing for Python
if !executable('mypy')
  execute '!pip install -U mypy'
end

" Static type checker for Python
if !executable('pyright')
  execute '!pip install -U pyright'
end

" Performant type-checking for python
if !executable('pyre')
  execute '!pip install -U pyre-check'
end

" Check the style and quality of some python code.
" It glues together pycodestyle, pyflakes, mccabe, and third-party plugins.
if !executable('flake8')
  execute '!pip install -U flake8'
end

" Provide information about type and location of classes, methods and more
if !executable('prospector')
  execute '!pip install -U prospector'
end

" Bandit is a tool designed to find common security issues in Python code
if !executable('bandit')
  execute '!pip install -U bandit'
end

" Find dead Python code
if !executable('vulture')
  execute '!pip install -U vulture'
end

" JavaScript Style Guide, with linter & automatic code fixer
if !executable('standard')
  execute '!npm install -g standard'
end

" A JSON parser and validator with a CLI
if !executable('jsonlint')
  execute '!npm install jsonlint -g'
end

" Style checker and lint tool for Markdown
if !executable('markdownlint')
  execute '!npm install -g markdownlint-cli'
end

" Natural language linter for text and markdown
if !executable('textlint')
  execute '!npm install -g textlint'
end

" A linter for prose
if !executable('proselint')
  execute '!pip install -U proselint'
end

" Naive linter for English prose
if !executable('write-good')
  execute '!npm install -g write-good'
end

" Catch insensitive, inconsiderate writing
if !executable('alex')
  execute '!npm install -g alex'
end

" A Spell Checker for Code!
if !executable('cspell')
  execute '!npm install -g cspell'
end

" Fixers.
let g:ale_fixers = {
  \ 'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace'],
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }

" Linters.
let g:ale_linters = {
  \ 'rust': ['analyzer'],
\ }

" }}}
" PLUGIN MANAGEMENT {{{

" Path to vim-plug
let autoload_plug = data_dir . '/autoload/plug.vim'

" Automatically install vim-plug if missing
if empty(glob(autoload_plug))
  execute '!rm ' . autoload_plug
  execute '!curl -fLo ' . autoload_plug .
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

  " Surroundings
  Plug 'tpope/vim-surround'

  " Restore sessions
  Plug 'tpope/vim-obsession'
  " Remember positions
  Plug 'farmergreg/vim-lastplace'

  " Increment dates, times and more
  Plug 'tpope/vim-speeddating'

  " Repeat stuff
  Plug 'tpope/vim-repeat'

  " Illuminate the current word
  Plug 'RRethy/vim-illuminate'
  " Toggle between hybrid and absolute line numbers automatically
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  " Show git markers
  Plug 'airblade/vim-gitgutter'
  " Integration with tmux
  Plug 'christoomey/vim-tmux-navigator'

  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Interactive coding scratchpad
  Plug 'metakirby5/codi.vim'

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

  " Personal Wiki
  Plug 'vimwiki/vimwiki'

  " Outline tags in the current line
  Plug 'preservim/tagbar'

  " GitHub copilot
  Plug 'github/copilot.vim'

  " Icons.
  " This should be the last plugin to be loaded.
  Plug 'ryanoasis/vim-devicons'
call plug#end()

" Ensure autoload/plug.vim is a symlink to plugged/vim-plug/plug.vim.
" This should come after plug#end().
if resolve(autoload_plug) == autoload_plug
  execute '!rm ' . autoload_plug
  execute '!ln -s -t ' . data_dir . '/autoload/ '
    \ . data_dir . '/plugged/vim-plug/plug.vim'
endif

" vim-plug already executes the following commands, but let's be *very*
" explicit again. This is required after plugin management for most plugin
" managers anyway.
filetype plugin indent on  " Load plugins according to detected filetype.
syntax on  " Enable syntax highlighting.

" }}}
" endif
