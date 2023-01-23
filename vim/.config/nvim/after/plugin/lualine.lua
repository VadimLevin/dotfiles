-- [[ Configure lualine ]]
-- See `:help lualine.txt`
local lualine = vim.F.npcall(require, 'lualine')

if not lualine then
    return
end

lualine.setup { }
