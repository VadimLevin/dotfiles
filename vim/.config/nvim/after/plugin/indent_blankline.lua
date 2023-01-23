-- [[ Configure `lukas-reineke/indent-blankline.nvim` ]]
-- See `:help indent_blankline.txt`

local indent_blankline = vim.F.npcall(require, 'indent_blankline')

if not indent_blankline then
    return
end

indent_blankline.setup {
    char = '┊',
    show_trailing_blankline_indent = false,
}
