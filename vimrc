
" ============================================================
" General
" ============================================================

" Use Vim defaults rather than legacy Vi compatibility.
set nocompatible

" Enable filetype detection, filetype plugins, and indentation rules.
filetype plugin indent on

" Enable syntax highlighting.
syntax on

" Remember more commands and search patterns.
set history=10000

" Allow switching buffers without saving the current one first.
set hidden

" Ask before discarding changes when an operation would lose them.
set confirm


" ============================================================
" Editing and indentation
" ============================================================

" Use four spaces for indentation by default.
" Filetype-specific indentation may override these defaults.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Preserve indentation when starting a new line.
set autoindent

" Allow Backspace over indentation, line breaks, and insert start.
set backspace=indent,eol,start

" Keep the cursor's screen position when moving between lines.
set nostartofline

" Persist undo history between editing sessions.
if has('persistent_undo')
    set undofile
endif


" ============================================================
" Searching
" ============================================================

" Ignore case unless the search contains uppercase characters.
set ignorecase
set smartcase

" Highlight matches and update search results while typing.
set hlsearch
set incsearch

" Use Esc to clear search highlighting without leaving Normal mode.
nnoremap <silent> <Esc> :nohlsearch<CR>


" ============================================================
" Window and tab navigation
" ============================================================

" Place horizontal and vertical splits below and to the right.
set splitbelow
set splitright

" Keep context visible around the cursor.
set scrolloff=8
set sidescrolloff=5

" Show the tab bar even when only one tab page exists.
set showtabline=2

" Navigate between tab pages with Ctrl+arrow keys.
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>


" ============================================================
" User interface
" ============================================================

" Show absolute line numbers and relative distances.
set number
set relativenumber

" Show the cursor position and partial commands.
set ruler
set showcmd

" Briefly highlight matching brackets.
set showmatch

" Always display a status line.
set laststatus=2

" Give the command line more room.
set cmdheight=2

" Make command-line completion more convenient.
set wildmenu
set wildmode=longest:full,full

" Enable mouse support when available.
if has('mouse')
    set mouse=a
endif

" Enable true color when supported by this Vim build.
if has('termguicolors')
    set termguicolors
endif


" ============================================================
" Completion
" ============================================================

" Show the completion menu even when there is only one match.
" Do not automatically select the first match.
set completeopt=menuone,noselect


" ============================================================
" Spell checking
" ============================================================

" Enable spell checking for English and German.
set spell
set spelllang=en_us,de_de


" ============================================================
" Colors
" ============================================================

" Choose your preferred colorscheme.
" Replace 'desert' with a colorscheme you have installed.
colorscheme desert


" ============================================================
" Trailing whitespace
" ============================================================

" Highlight trailing whitespace, but avoid clearing unrelated matches.
highlight ExtraWhitespace ctermbg=red guibg=red

augroup trailing_whitespace
    autocmd!
    autocmd BufWinEnter,InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup END
