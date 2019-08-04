" ----------------------------------------------------------------------------
"                             Table of Contents
" ----------------------------------------------------------------------------
" 1. General configurations
" 2. Plugins
" 3. Appearance
" 4. Key Bindings
" 5. Utility Functions
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
let mapleader = ","
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
" Minimal number of screen lines to keep above and below the cursor
set scrolloff=8
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
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
" ----------------------------------------------------------------------------
"                                 Plugins
" ----------------------------------------------------------------------------
filetype off
" Runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'VundleVim/Vundle.vim'
  " Paper color theme for vim
  Plugin 'NLKNguyen/papercolor-theme'
  " Tree explorer
  Plugin 'scrooloose/nerdtree'
  " Git plugin for tree explorer
  Plugin 'Xuyuanp/nerdtree-git-plugin'
  " Show git changes in the 'gutter' (sign column)
  Plugin 'airblade/vim-gitgutter'
  " Pretty color scheme
  Plugin 'morhetz/gruvbox'
  " Custom status line
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
call vundle#end()
" Attempt to determine the type of a file based on its name and possibly its
" contents.
filetype indent plugin on
" -------------------------------
"     NERDTree File explorer
" -------------------------------
" Automatically open tree explorer when vim starts up opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
        \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
        \ | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0]
        \ | endif
" -------------------------------
"     NETRW Default File explorer
" -------------------------------
" Disable banner
let g:netrw_banner=0
" Open splits to the right
let g:netrw_browse_split=4
" Open splits to the right
let g:netrw_altv=1
" Enable tree view
let g:netrw_liststyle=3
" ----------------------------------------------------------------------------
"                           Appearance
" ----------------------------------------------------------------------------
" -------------------------------
"           General
" -------------------------------
" Enable syntax highlighting
syntax on
" Add a bit extra margin to the left
set foldcolumn=1
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
" Set the command window height to 2 lines
set cmdheight=2
" GUI fonts
if has('gui_running') && has('gui_win32')
  set guifont=Consolas:h10
else
  set guifont=DejaVu\ Sans\ Mono\ 10
endif
" -------------------------------
"             Theme
" -------------------------------
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
set background=light
set termguicolors
try
  let g:gruvbox_guisp_fallback='bg'
  let g:gruvbox_contrast_light='hard'
  let g:gruvbox_contrast_dark='hard'
  let g:gruvbox_italic=1
  let g:gruvbox_improved_warnings=1
  let g:gruvbox_undercurl=1
  colorscheme gruvbox
catch
  colorscheme desert
endtry
" ----------------------------------------------------------------------------
"                           Key Bindings
" ----------------------------------------------------------------------------
" Maps toggle to specific key
map <C-n> :NERDTreeToggle<CR>
" Fast saving
nmap <leader>w :w!<cr>
" Moving between buffers
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Auto indent pasted text
nnoremap p p=`]<C-o>
" Disable highlight when <leader><cr> is pressed
nnoremap P P=`]<C-o>
map <silent> <leader><cr> :noh<cr>
" Remap VIM 0 to first non-blank character
" Move a line of text using ALT+[jk]
map 0 ^
" Here goes an workaround to work in terminals Ctrl-V + Alt + key
nnoremap j :m .+1<CR>==
nnoremap k :m .-2<CR>==
inoremap j <Esc>:m .+1<CR>==gi
inoremap k <Esc>:m .-2<CR>==gi
vnoremap j :m '>+1<CR>gv=gv
vnoremap k :m '<-2<CR>gv=gv
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" ----------------------------------------------------------------------------
"                           Utility Functions
" ----------------------------------------------------------------------------
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

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
