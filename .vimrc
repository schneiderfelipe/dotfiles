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

" Set Leader to Space (with \ and , as aliases)
let mapleader = " "
nmap <bslash> <space>
nmap , <space>

" Do not redraw screen while executing macros
set lazyredraw

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

" Turn on mouse support in all modes.
set mouse=a
" Keep copy-on-select and other GUI options.
" set clipboard+=autoselect
set guioptions+=a
" Enter insert mode on left-click.
nnoremap <LeftMouse> <LeftMouse>i

" Turn on spellcheck.
set spell
" Set spellcheck highlight to underline.
hi clear SpellBad
hi SpellBad cterm=underline

" Allow inserting LaTeX symbols as Unicode everywhere, courtesy of the Julia
" Vim plugin.
let g:latex_to_unicode_file_types = ".*"

" Configure what file types to ignore.
let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
" Configure buffer types to ignore.
let g:lastplace_ignore_buftype = "quickfix,nofile,help"
" Automatically open folds when jumping to the last edit position.
let g:lastplace_open_folds = 0


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

" Syntax highlighting for Prolog
let g:filetype_pl="prolog"


" Four indents, space between redirects, indented case statements, simplified.
let g:shfmt_extra_args = '-i 4 -sr -ci -s'
let g:shfmt_fmt_on_save = 1
augroup LocalShell
    autocmd!

    autocmd BufWritePre *.sh,*.bash Shfmt
augroup END

" List all of the extensions for which prettier should run.
autocmd BufWritePre *.css,*.graphql,*.html,*.js,*.json,*.jsx,*.less,*.md,*.mjs,*.scss,*.svelte,*.ts,*.tsx,*.vue,*.yaml,.babelrc,.eslintrc,.jshintrc PrettierAsync

" Avoid hanging when opening files with too many changes
let g:gitgutter_max_signs = 1000

" Use evince as the PDF viewer for VimTeX
let g:vimtex_view_general_viewer = 'evince'

" Engines configuration for VimTeX
let g:vimtex_compiler_latexmk_engines = {
      \ '_'                : '-lualatex',
      \ 'pdflatex'         : '-pdf',
      \ 'dvipdfex'         : '-pdfdvi',
      \ 'pdfdvi'           : '-pdfdvi',
      \ 'pdfps'            : '-pdfps',
      \ 'lualatex'         : '-lualatex',
      \ 'luatex'           : '-lualatex',
      \ 'xelatex'          : '-xelatex',
      \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
      \ 'context (luatex)' : '-pdf -pdflatex=context',
      \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
      \}

" }}}
" WIKI {{{

" General configuration
let g:vimwiki_list = [{'path': '~/Dropbox/notes',
                      \ 'diary_index': 'index', 'auto_diary_index': 1,
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Add a header automatically when a new note is created
let g:vimwiki_auto_header = 1

" Use a simpler set of markers in tasks
let g:vimwiki_listsyms = ' x'

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

" Be smart about inserting tabs.
set smarttab

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

" Remove trailing whitespace on save.
autocmd BufWritePre * :%s/\s\+$//e

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


" Tell vim to remember certain things when we exit
"  '100  :  marks will be remembered for up to 100 previously edited files
"  "20000:  will save up to 20,000 lines for each register
"  :200  :  up to 200 lines of command-line history will be remembered
"  s20   :  up to 20 kilobytes will be saved for each register
"  %     :  saves and restores the buffer list
"  h     :  disables search highlighting when Vim starts
"  n...  :  where to save the viminfo files
set viminfo='100,\"20000,:200,s20,%,h,n~/.viminfo

" }}}
" ASYNCHRONOUS LINT ENGINE {{{

" Don't check immediately on open (or quit).
let g:ale_fix_on_enter = 0
let g:ale_lint_on_enter = 0
" Check and fix on save.
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1

" As-you-type autocomplete.
set completeopt=preview,menu,menuone,noselect,noinsert
let g:ale_completion_enabled = 1

" These emojis go in the sidebar for errors and warnings.
let g:ale_sign_error = '☢️'
let g:ale_sign_warning = '⚡'

" Show error count.
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

" How to show error messages.
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


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
" TODO: add more
let g:ale_fixers = {
  \ 'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace'],
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }

" Linters.
" TODO: add more
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
  " {{{ Basic plugins
  Plug 'junegunn/vim-plug'  " Help for vim-plug itself.
  Plug 'tpope/vim-sensible' " Sensible defaults
  " }}}
  " {{{ Basic enhancements
  Plug 'tpope/vim-obsession'   " Restore sessions
  Plug 'tpope/vim-repeat'      " Repeat stuff
  Plug 'tpope/vim-sleuth'      " Automatic indentation detection
  Plug 'tpope/vim-speeddating' " Increment dates, times and more
  Plug 'tpope/vim-surround'    " Surroundings
  Plug 'andymass/vim-matchup'  " Improved matchit and matchparen
  " }}}
  " {{{ Language support
  Plug 'neovim/nvim-lspconfig'

  Plug 'JuliaEditorSupport/julia-vim'
  Plug 'rust-lang/rust.vim'
  Plug 'lervag/vimtex'
  Plug 'freitass/todo.txt-vim'
  Plug 'daveyarwood/vim-alda'

  Plug 'tpope/vim-markdown'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'quarto-dev/quarto-vim'
  Plug 'quarto-dev/quarto-nvim'
  " }}}
  " {{{ User interface
  Plug 'RRethy/vim-illuminate'               " Illuminate the current word
  Plug 'airblade/vim-gitgutter'              " Show git markers
  Plug 'christoomey/vim-tmux-navigator'      " Integration with tmux
  Plug 'farmergreg/vim-lastplace'            " Remember positions
  Plug 'jeffkreeftmeijer/vim-numbertoggle'   " Toggle between hybrid and absolute line numbers automatically
  Plug 'lukas-reineke/indent-blankline.nvim' " Indent guides
  Plug 'preservim/tagbar'                    " Outline tags in the current line
  Plug 'peterbjorgensen/sved'                " Synctex support for Vim and Evince through DBus
  " }}}
  " {{{ Status line
  Plug 'vim-airline/vim-airline'             " Status line
  Plug 'vim-airline/vim-airline-themes'      " Themes for the status line
  Plug 'edkolev/tmuxline.vim'                " Set tmux's status line to match Vim's
  " }}}
  " {{{ Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " }}}
  " {{{ Coding enhancements
  Plug 'dense-analysis/ale'  " Asynchronous lint engine
  Plug 'metakirby5/codi.vim' " Interactive coding scratchpad
  Plug 'github/copilot.vim'  " GitHub copilot
  Plug 'prettier/vim-prettier', { 'do': 'npm install' }  " Format with Prettier
  " }}}
  " {{{ Personal Wiki
  Plug 'vimwiki/vimwiki'
  " }}}
  " {{{ Colors and icons
  Plug 'sainnhe/sonokai'        " Monokai-inspired colorscheme
  Plug 'ryanoasis/vim-devicons' " Icons (this should be the last plugin to be loaded)
  " }}}
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
syntax on  " Turn on the syntax checker

" Redefine the keybinding for Synctex forward synchronization
nmap \lv :call SVED_Sync()<CR>

" }}}
" endif
