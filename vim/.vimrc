" ----------------------------------------------------------------------------
"                             Table of Contents
" ----------------------------------------------------------------------------
"
" 1. General configurations
" 2. Appearance
" 3. Key Bindings
" 4. Utility Functions
"
" ----------------------------------------------------------------------------
"                                 General
" ----------------------------------------------------------------------------
" Remove compatibility to Vi
set nocompatible
" Use UTF-8 without BOM encoding
scriptencoding utf-8
set encoding=utf-8 nobomb
" Enable spell checking mechanism
if has('spell')
  set spell spelllang=en_us
  set complete+=kspell
endif
" Set to auto read when a file is changed from the outside
set autoread
" With a map leader it's possible to do extra key combinations
let mapleader = " "
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
" Show dialog asking to save changed files
set confirm
" Always go to the first character of a line
set nostartofline
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Minimal number of screen lines to keep from the above and below the cursor
if !&scrolloff
    set scrolloff=8
endif
" Minimal number of columns to keep from the left and right of the cursor
if !&sidescrolloff
    set sidescrolloff=5
endif
" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif
if &history < 1000
    set history=1000
endif
if &tabpagemax < 50
    set tabpagemax=50
endif

" When included, as much as possible of the last line in a window will
" be displayed.
set display+=lastline

" -------------------------------
"     Search configuration
" -------------------------------
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
" -------------------------------
"     Indent configuration
" -------------------------------
" Tab size in spaces
set tabstop=4
" Do not use the actual tab character
set expandtab
" Tabs width when indenting with spaces
set shiftwidth=4
set softtabstop=4
" Copy indentation from the previous line
set autoindent
" Automatically insert one extra level of indentation when it's possible
set smartindent
" -------------------------------
"     NETRW Default File explorer
" -------------------------------
" Disable banner
let g:netrw_banner=0
" Open files in previous window
let g:netrw_browse_split=4
" Open splits to the right
let g:netrw_altv=1
" Set the width of the directory explorer
let g:netrw_winsize=25
" Enable tree view
let g:netrw_liststyle=3
" Open NETRW in the vertical split on start-up
" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END

" ----------------------------------------------------------------------------
"                               Appearance
" ----------------------------------------------------------------------------
" -------------------------------
"           General
" -------------------------------
" Enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif
" Add a bit extra margin to the left
set foldcolumn=1
" Show the cursor position
set ruler
" Show the current mode
set showmode
" Show 'invisible' characters
set listchars=tab:>.,trail:·,extends:>,precedes:<
set list
" Show the filename in the window title bar
set title
" highlight the 80 and 120 column limit
set colorcolumn=80,120
" === Line numbers ===
" Displays absolute line number
set number
" Displays line number relative to current line
set relativenumber
" Show status line
set laststatus=2
set statusline=%t                               " Tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " File encoding
set statusline+=%{&ff}]                         " File format
set statusline+=%h                              " Help file flag
set statusline+=%m                              " Modified flag
set statusline+=%r                              " Read only flag
set statusline+=%y                              " File type
set statusline+=%=                              " Left/right separator
set statusline+=%c,                             " Cursor column
set statusline+=\ %l/%L                         " Cursor line/total lines
set statusline+=\ %P                            " Percent through file
" Set the command window height to 2 lines (gives more space for displaying
" messages)
set cmdheight=2
" GUI fonts
if has('gui_running') && has('gui_win32')
  set guifont=Consolas:h10
else
  set guifont=DejaVu\ Sans\ Mono\ 10
endif

set background=dark

" ----------------------------------------------------------------------------
"                               Key Bindings
" ----------------------------------------------------------------------------

" Fast saving
nmap <leader>w :w!<cr>
" Moving between buffers
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Auto indent pasted text
" nnoremap p p=`]<C-o>
" Disable highlight when <leader><cr> is pressed
" nnoremap P P=`]<C-o>
map <silent> <leader><cr> :noh<cr>
" Remap VIM 0 to first non-blank character
map 0 ^
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Move selection up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Let Y behave in the same way as other capital letters
nnoremap Y yg$

" Keep cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" ----------------------------------------------------------------------------
"                            Utility Functions
" ----------------------------------------------------------------------------
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

