-- Mappings

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>dh', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'dk', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'dj', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
    _ = client
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require "lsp_signature".on_attach({
        hint_prefix = " ",
    }, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>df', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require("neodev").setup {
    library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false

    -- override = function(root_dir, options)
    -- end,

    -- With lspconfig, Neodev will automatically setup your lua-language-server
    -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
    -- in your lsp start options
    lspconfig = true,
    -- much faster, but needs a recent built of lua-language-server
    -- needs lua-language-server >= 3.6.0
    pathStrict = true,
}

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
-- require('lspconfig')['rust_analyzer'].setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     settings = {
--         ["rust-analyzer"] = {}
--     },
-- }
require("rust-tools").setup {
    server = {
        on_attach = on_attach,
    },
    inlay_hints = {
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
    }
}
require('rust-tools').inlay_hints.enable()
require('lspconfig')['lua_ls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
}
require('lspconfig')['bashls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['clangd'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['cssls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['html'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['jdtls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['jsonls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['marksman'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['vimls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
