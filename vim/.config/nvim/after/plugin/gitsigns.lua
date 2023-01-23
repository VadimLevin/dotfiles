-- [[ Configure Gitsigns ]]
-- See `:help gitsigns.txt`

local gitsigns = vim.F.npcall(require, 'gitsigns')

if not gitsigns then
    return
end

gitsigns.setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    }
}
