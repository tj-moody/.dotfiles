-- Mappings
local map = vim.keymap.set
local float_namespace = vim.api.nvim_create_namespace 'tj_lsp_float'

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local map_opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>dh', vim.diagnostic.open_float, map_opts)
vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, map_opts)
vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, map_opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

require("hover").setup {
    init = function()
        -- Require providers
        require("hover.providers.lsp")
        require('hover.providers.gh')
        require('hover.providers.dictionary')
        -- require('hover.providers.gh_user')
        -- require('hover.providers.jira')
        -- require('hover.providers.man')
    end,
    preview_opts = {
        border = nil
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = false,
    title = true
}

---LSP handler that adds extra inline highlights, keymaps, and window options.
---Code inspired from `noice`
---@param handler fun(err: any, result: any, ctx: any, config: any): integer, integer
---@return function
local function enhanced_float_handler(handler)
    -- tweaked from https://github.com/MariaSolOs/dotfiles/blob/bda5388e484497b8c88d9137c627c0f24ec295d7/.config/nvim/lua/lsp.lua#L214-L236
    return function(err, result, ctx, config)
        local buf, win = handler(
            err,
            result,
            ctx,
            vim.tbl_deep_extend('force', config or {}, {
                border = 'rounded',
                title = "  ",
                max_height = math.floor(vim.o.lines * 0.5),
                max_width = math.floor(vim.o.columns * 0.4),
            })
        )

        if not buf or not win then
            return
        end

        -- Conceal everything.
        vim.wo[win].concealcursor = 'n'

        -- Extra highlights.
        for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
            for pattern, hl_group in pairs {
                ['|%S-|'] = '@text.reference',
                ['@%S+'] = '@parameter',
                ['^%s*(Parameters:)'] = '@text.title',
                ['^%s*(Return:)'] = '@text.title',
                ['^%s*(See also:)'] = '@text.title',
                ['{%S-}'] = '@parameter',
                ['^%s*(%{%{%{)'] = 'Conceal', -- For vim folds showing up in documentation
                ['^%s*(%}%}%})'] = 'Conceal',
            } do
                local conceal = nil
                local from = 1 ---@type integer?
                while from do
                    local to
                    from, to = line:find(pattern, from)
                    if hl_group == 'Conceal' then
                        conceal = ''
                    end
                    if from then
                        vim.api.nvim_buf_set_extmark(buf, float_namespace, l - 1, from - 1, {
                            end_col = to,
                            hl_group = hl_group,
                            conceal = conceal,
                        })
                    end
                    from = to and to + 1 or nil
                end
            end
        end

        -- Add keymaps for opening links.
        if not vim.b[buf].markdown_keys then
            vim.keymap.set('n', 'K', function()
                -- Vim help links.
                local url = (vim.fn.expand '<cWORD>' --[[@as string]]):match '|(%S-)|'
                if url then
                    return vim.cmd.help(url)
                end

                -- Markdown links.
                local col = vim.api.nvim_win_get_cursor(0)[2] + 1
                local from, to
                from, to, url = vim.api.nvim_get_current_line():find '%[.-%]%((%S-)%)'
                if from and col >= from and col <= to then
                    vim.system({ 'open', url }, nil, function(res)
                        if res.code ~= 0 then
                            vim.notify('Failed to open URL' .. url, vim.log.levels.ERROR)
                        end
                    end)
                end
            end, { buffer = buf, silent = true })
            vim.b[buf].markdown_keys = true
        end
    end
end

local methods = vim.lsp.protocol.Methods
vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover)
vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help)

-- Setup keymaps
-- vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
-- vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})

local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require("lsp_signature").on_attach({
        hint_scheme = 'Normal',
        hint_prefix = " ",
        bind = true,
        handler_opts = {
            border = "rounded"
        }
    }, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    -- Possibly switch back to hover if builtin prettier hover is integrated
    -- map('n', 'K', require("hover").hover, bufopts)
    -- map('n', 'gK', require("hover").hover_select, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', 'gs', vim.lsp.buf.signature_help, bufopts) -- "go type"
    -- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- map('n', '<space>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    map('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
    map('n', '<leader>df', function()
        -- vim.cmd("norm! mz")
        vim.lsp.buf.format { async = false }
        -- vim.cmd("norm! `z")
        -- vim.cmd("norm! zo")
    end, bufopts)
end

require("neodev").setup {
    library = { plugins = { "neotest" }, types = true },
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
    tools = {
        inlay_hints = {
            auto = false
        }
    },
}
require('rust-tools').inlay_hints.disable()
require('lspconfig')['lua_ls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    'vim',
                    'P',
                    'safe_require',
                },
                disable = {
                    "lowercase-global",
                },
            },
            hint = {
                enable = true,
                arrayIndex = "Disable",
            },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
                version = 'LuaJIT',
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
require('lspconfig')['asm_lsp'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['texlab'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

vim.cmd('source ~/.dotfiles/nvim/lua/config/cmp.lua')
