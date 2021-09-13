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

    let g:edge_style = 'aura'
    let g:edge_enable_italic = 1
    let g:edge_disable_italic_comment = 1
    silent! colorscheme edge
endif
