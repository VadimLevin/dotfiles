runtime ./plugins.vim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists("&termguicolors") && exists("&winblend")
    set termguicolors
    set winblend=0
    set wildoptions=pum
    set pumblend=5
    set background=dark

    silent! colorscheme gruvbox
endif
