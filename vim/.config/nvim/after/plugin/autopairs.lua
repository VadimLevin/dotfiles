local autopairs = vim.F.npcall(require, "nvim-autopairs")
if not autopais then
    return
end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

