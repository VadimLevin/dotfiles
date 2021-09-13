if !exists('g:loaded_nvim_treesitter')
    finish
endif

lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {}
    },
    autopairs = {
        enable = true,
        disable = {}
    },
    indent = {
        enable = false,
        disable = {}
    },
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cuda",
        "cpp",
        "dockerfile",
        "lua",
        "python",
        "json",
        "vim",
        "yaml",
    }
}
EOF

