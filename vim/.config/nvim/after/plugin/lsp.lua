-- [[ Configure LSP ]]

local lspconfig = vim.F.npcall(require, 'lspconfig')

if not lspconfig then
    print 'lspconfig is not available'
    return
end

local mason = vim.F.npcall(require, 'mason')
if not mason then
    print 'mason is not available'
    return
end

local mason_lspconfig = vim.F.npcall(require, 'mason-lspconfig')
if not mason_lspconfig then
    print 'mason-lspconfig is not available'
    return
end


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_action = function(client, bufnr)
    local set_keymap = function(mode, keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc})
    end
    local set_keymap_normal = function(keys, func, desc)
        set_keymap('n', keys, func, desc)
    end
    local set_keymap_visual = function(keys, func, desc)
        set_keymap('v', keys, func, desc)
    end

    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    set_keymap_normal('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

    set_keymap_normal('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    set_keymap_normal('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    set_keymap_normal('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    set_keymap_normal('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    set_keymap_normal('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    set_keymap_normal('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    set_keymap_normal('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    set_keymap_normal('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    set_keymap_normal('K', vim.lsp.buf.hover, 'Hover Documentation')
    set_keymap_normal('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    set_keymap_normal('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    set_keymap_normal('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    set_keymap_normal('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    set_keymap_visual('<leader>af', vim.lsp.buf.format, '[A]pply [F]ormatting to selected range')
    set_keymap_normal('<leader>af', vim.lsp.buf.format, '[A]pply [F]ormatting to whole document')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enabling and configuring language servers
local servers_configs = {
    pylsp = { },
    clangd = {
        cmd = {
            'clangd',
            '--background-index',
            '--compile-commands-dir=build',
            '--suggest-missing-includes',
            '--completion-style=detailed',
            '--clang-tidy',
            '-j=4'
        },
    },
    cmake = {
        filetypes = {
            'cmake',
            'CMakeLists.txt'
        },
        init_options = 'build/'
    }
}

local neodev = vim.F.npcall(require, 'neodev')
if neodev then
    neodev.setup()
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
-- completion configuration
local cmp_nvim_lsp = vim.F.npcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

mason.setup()

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers_configs),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        config = vim.tbl_deep_extend('force', {
            capabilities = capabilities,
            on_attach = on_attach_action,
        }, servers_configs[server_name])
        lspconfig[server_name].setup(config)
    end,
}

-- Turn on lsp status information
local figet = vim.F.npcall(require, 'fidget')
if fidget then
    fidget.setup()
end
