-- Mappings
local map = vim.keymap.set

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local map_opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>dh', vim.diagnostic.open_float, map_opts)
vim.keymap.set('n', 'dk', vim.diagnostic.goto_prev, map_opts)
vim.keymap.set('n', 'dj', vim.diagnostic.goto_next, map_opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require "lsp_signature".on_attach({
        hint_scheme = 'Normal',
        hint_prefix = " ",
        hint_inline = function() return false end,
        -- bind = true,
        -- handler_opts = {
        --     border = "rounded"
        -- }
    }, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', 'gs', vim.lsp.buf.signature_help, bufopts) -- "go type"
    -- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- map('n', '<space>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
    map('n', '<leader>df', function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
end

local neodev_opts = {}
require("neodev").setup(neodev_opts)

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local inlayhints_opts = {
    inlay_hints = {
        highlight = "FoldColumn",
        -- highlight = "Statement",
        -- highlight = "Folded",
        -- highlight = "Comment",
        -- highlight = "Normal",
    }
}
require("lsp-inlayhints").setup(inlayhints_opts)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, args.buf)
    end,
})

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
    tools = {
        inlay_hints = {
            auto = false
        }
    },
}
require('rust-tools').inlay_hints.disable()
require('lspconfig')['lua_ls'].setup {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        require("lsp-inlayhints").on_attach(client, bufnr)
    end,
    flags = lsp_flags,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            hint = {
                enable = true,
                arrayIndex = "Disable",
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

vim.cmd('source ~/.dotfiles/nvim/lua/config/cmp.lua')
