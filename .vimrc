"""""""""""
" General "
"""""""""""

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Set maximum tabs available via 'vim -p '
set tabpagemax=50

" Sets number of lines of history VIM has to remember
set history=500

" Enable mouse support
if has('mouse')
  set mouse=a
endif

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches
set hlsearch
" search as characters are entered
set incsearch

" Enable spell checking
set spell spelllang=en_us,de_de

""""""""""""""
" Usabillity "
""""""""""""""

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

"""""""""""""""
" Indentation "
"""""""""""""""

" coming from other editors would expect.
set tabstop=6
set softtabstop=6

" set spaces instead of tabs
set expandtab

" Linebreak on 72 characters
"set lbr
"set tw=72

""""""""""""""""""
" User Interface "
""""""""""""""""""

" Highlight matching [{()}]
set showmatch

""""""""""""""""""""
" Show whitespaces "
""""""""""""""""""""

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
