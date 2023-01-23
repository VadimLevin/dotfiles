vim.g.python3_host_prog = '/Users/xperience/.pyenv/versions/neovim/bin/python'

require('vlevin.options')
require('vlevin.remap')
require('vlevin.plugins')


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
