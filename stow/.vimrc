" INDENTATION
" New lines inherit the indentation of previous lines.
set autoindent
" Convert tabs to spaces.
set expandtab
" Enable indentation rules that are file-type specific.
filetype plugin indent on
" When shifting lines, round the indentation to the nearest multiple of shiftwidth.
set shiftround
" When shifting, indent using four spaces.
set shiftwidth=4
" Insert “tabstop” number of spaces when the tab key is pressed.
set smarttab
" Indent using four spaces.
set tabstop=4
" Set characters that should be shown instead of whitespace characters.
set listchars=tab:→→
" Enable whitespace replacement.
set list

" SEARCH
" Enable search highlighting.
set hlsearch
" Ignore case when searching.
set ignorecase
" Incremental search that shows partial matches.
set incsearch
" Automatically switch search to case-sensitive when search query contains an uppercase letter.
set smartcase

" PERFORMANCE
" Limit the files searched for auto-completes.
set complete-=i
" Don’t update screen during macro and script execution.
set lazyredraw

" TEXT RENDERING
" Always try to show a paragraph’s last line.
set display+=lastline
" Use an encoding that supports unicode.
set encoding=utf-8
" Avoid wrapping a line in the middle of a word.
set linebreak
" The number of screen lines to keep above and below the cursor.
set scrolloff=1
" The number of screen columns to keep to the left and right of the cursor.
set sidescrolloff=5
" Enable syntax highlighting.
syntax enable
" Enable line wrapping.
set wrap

" USER INTERFACE
" Always display the status bar.
set laststatus=2
" Always show cursor position.
set ruler
" Display command line’s tab complete options as a menu.
set wildmenu
" Maximum number of tab pages that can be opened from the command line.
set tabpagemax=50
" Change color scheme.
" set colorscheme wombat256mod
" Highlight the line currently under cursor.
set cursorline
" Show line numbers on the sidebar.
set number
" Show line number on the current line and relative numbers on all other lines.
" set relativenumber
" Disable beep on errors.
set noerrorbells
" Flash the screen instead of beeping on errors.
" set visualbell
" Enable mouse for scrolling and resizing.
set mouse=a
" Set the window’s title, reflecting the file currently being edited.
set title
" Use colors that suit a dark background.
set background=dark

" CODE FOLDING
" Fold based on indention levels.
set foldmethod=indent
" Only fold up to three nested levels.
set foldnestmax=3
" Disable folding by default.
set nofoldenable

" MISCELLANEOUS
" Automatically re-read files if unmodified inside Vim.
set autoread
" Allow backspacing over indention, line breaks and insertion start.
set backspace=indent,eol,start
" Directory to store backup files.
set backupdir=~/.cache/vim
" Display a confirmation dialog when closing an unsaved file.
set confirm
" Directory to store swap files.
set dir=~/.cache/vim
" Delete comment characters when joining lines.
set formatoptions+=j
" Hide files in the background instead of closing them.
" set hidden
" Increase the undo limit.
set history=1000
" Ignore file’s mode lines; use vimrc configurations instead.
" set nomodeline
" Disable swap files.
" set noswapfile
" Interpret octal as decimal when incrementing numbers.
" set nrformats-=octal
" The shell used to execute commands.
set shell=/bin/zsh
" Enable spellchecking.
" set spell
" Ignore files matching these patterns when opening files based on a glob pattern.
" set wildignore+=.pyc,.swp
