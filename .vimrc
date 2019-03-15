" === Basic config ===
" Remove compatibility to Vi
set nocompatible
" Use UTF-8 without BOM encoding
scriptencoding utf-8
set encoding=utf-8 nobomb
" Attempt to determine the type of a file based on its name and possibly its
" contents.
filetype indent plugin on
" Enable spell checking mechanism
:set spell spelllang=en_us
:set complete+=kspell

" Enhance command-line completion
set wildmenu
" Allow to re-use the same window and switch from an unsaved buffer without
" saving it first
set hidden
" Show partial commands in the last line of the screen
set showcmd
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline
" Set the command window height to 2 lines
set cmdheight=2
" Show dialog asking to save changed files
set confirm
" Always go to the first character of a line
set nostartofline
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" === Theme ===
set background=dark
if has('gui_running')
  set lines=60 columns=90 linespace=0
  if has('gui_win32')
    set guifont=Source_Code_Pro:h10
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
  endif
else
  if has('win32')
    colorscheme darkblue
  endif
endif

" === Highlighting ===
" Show status line
set laststatus=2
" Enable syntax highlighting
syntax on
" Show the cursor position
set ruler
" Show the current mode
set showmode
" Show 'invisible' characters
set listchars=tab:>.,trail:·,extends:>,precedes:<
set list
" Show the filename in the window titlebar
set title
" highlight the 80 column limit
set colorcolumn=80

" === Line numbers ===
" Displays absolute line number
set number
" Displays line number relative to current line
set relativenumber

" === Indenting ===
" Tab size in spaces
set tabstop=2
" Do not use the actual tab character
set expandtab
" Tabs width when indenting with spaces
set shiftwidth=2
set softtabstop=2
" Copy indentation from the previous line
set autoindent
" Automatically insert one extra level of indentation when it's possible
set smartindent

" === Search ===
" Highlight searches
set hlsearch
" Show match as search proceeds
set incsearch
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" === File Browsing with NETRW ===
" Disable banner
let g:netrw_banner=0
" Open splits to the right
let g:netrw_browse_split=4
" Open splits to the right
let g:netrw_altv=1
" Enable tree view
let g:netrw_liststyle=3
