local nvim_tree = vim.F.npcall(require, 'nvim-tree')
if not nvim_tree then
    return
end

nvim_tree.setup()

-- Maps toggle to specific key
vim.keymap.set('', '<C-n>', vim.cmd.NvimTreeToggle)
