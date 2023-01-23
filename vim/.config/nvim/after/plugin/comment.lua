-- [[ Enable Comment.nvim ]]
local comment = vim.F.npcall(require, 'Comment')
if not comment then
    return
end

comment.setup()
