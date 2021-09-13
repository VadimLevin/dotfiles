call plug#begin('~/.config/nvim/plugged')
" Git integration
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'kamykn/spelunker.vim'

" Debugger plugin
Plug 'puremourning/vimspector'
" Source tree viewer
Plug 'scrooloose/nerdtree'
" Theme
Plug 'morhetz/gruvbox'
Plug 'szw/vim-maximizer'
Plug 'hoob3rt/lualine.nvim'

Plug 'NLKNguyen/papercolor-theme'

if has("nvim")
    Plug 'sainnhe/edge'
    Plug 'lewis6991/gitsigns.nvim'

    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim'
    " Automatically creates missing LSP diagnostics highlight groups for color 
    " schemes
    Plug 'folke/lsp-colors.nvim'

    Plug 'folke/tokyonight.nvim', {'branch': 'main'}

    Plug 'nvim-lua/completion-nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'windwp/nvim-autopairs'

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
endif

call plug#end()
