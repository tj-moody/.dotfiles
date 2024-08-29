local M = {}

local function cmp_setup()
    local luasnip = require("luasnip")
    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(
            0, line - 1, line, true
        )[1]:sub(col, col):match("%s") == nil
    end

    -- local symbol_map = {
    --     Text = "",
    --     Method = "",
    --     Function = "",
    --     Constructor = "",
    --     Field = "ﰠ",
    --     Variable = "",
    --     Class = "ﴯ",
    --     Interface = "",
    --     Module = "",
    --     Property = "ﰠ",
    --     Unit = "塞",
    --     Value = "",
    --     Enum = "",
    --     Keyword = "",
    --     Snippet = "",
    --     Color = "",
    --     File = "",
    --     Reference = "",
    --     Folder = "",
    --     EnumMember = "",
    --     Constant = "",
    --     Struct = "פּ",
    --     Event = "",
    --     Operator = "",
    --     TypeParameter = "",
    -- }

    local cmp = require('cmp')

    ---@diagnostic disable missing-fields
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            completion = {
                col_offset = -3,
                side_padding = 0,
            },
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.cmdline {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            -- ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.confirm({ select = false }),
            -- Accept currently selected item. Set `select`
            -- to `false` to only confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                -- Don't allow tab to cycle while
                -- able to jump to next snippet location
                if cmp.visible() and not luasnip.expand_or_jumpable() then
                    cmp.select_next_item()
                    -- You could replace the expand_or_jumpable()
                    -- calls with expand_or_locally_jumpable()
                    -- that way you will only jump inside the snippet region
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-N>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-P>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        sources = cmp.config.sources(
            {
                { name = 'nvim_lsp' },
            },
            {
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'path' },
            },
            {
                { name = 'buffer' },
                -- { name = 'cmdline' },
            }
        ),
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                -- Kind icons
                local kind = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"
                -- kind.menu = ({
                --     buffer = "(Buf)",
                --     nvim_lsp = "(LSP)",
                --     luasnip = "(SNP)",
                --     nvim_lua = "(Lua)",
                --     latex_symbols = "(Text)",
                --     cmdline = "(Cmd)"
                -- })[entry.source.name]
                return kind
            end,
        },
        completion = {
            keyword_length = 2,
        },
        experimental = {
            -- ghost_text = { hl_group = 'Comment' },
            ghost_text = true,
        },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            -- You can specify the `cmp_git` source if you were installed it.
            { name = 'cmp_git' },
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?`
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':'
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

    vim.diagnostic.config {
        virtual_text = true,
        virtual_lines = false,
        underline = true,
    }

    -- TODO: Unclear how this setup prioritizes multiple severities on the same line
    local diagnostic_lines_ns = vim.api.nvim_create_namespace("Diagnostic_Lines")
    local orig_signs_handler = vim.diagnostic.handlers.signs
    local function severity_highlight(severity)
        if severity == vim.diagnostic.severity.HINT then
            return 'DiffAdd'
        elseif severity == vim.diagnostic.severity.INFO then
            return 'DiffChange'
        elseif severity == vim.diagnostic.severity.WARN then
            return 'DiffDelete'
        end
        return 'DiffDelete' -- severity == Error
    end
    vim.diagnostic.handlers.signs = {
        show = function(_, bufnr, _, opts)
            -- Handle diagnostics for whole buffer for ns convenience
            local diagnostics = vim.diagnostic.get(bufnr)
            for _, diagnostic in ipairs(diagnostics) do
                vim.api.nvim_buf_set_extmark(
                    diagnostic.bufnr,
                    diagnostic_lines_ns,
                    diagnostic.lnum, 0,
                    { line_hl_group = severity_highlight(diagnostic.severity) }
                )
            end
            orig_signs_handler.show(diagnostic_lines_ns, bufnr, diagnostics, opts)
        end,
        hide = function(_, bufnr)
            vim.api.nvim_buf_clear_namespace(bufnr, diagnostic_lines_ns, 0, -1)
            orig_signs_handler.hide(diagnostic_lines_ns, bufnr)
        end,
    }

    require("lsp_lines").setup()

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
            texthl = sign.name,
            text = sign.text,
            numhl = "",
        })
    end
end

local function lspconfig_setup()
    local m_b = function(mode, lhs, rhs, buff, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = buff, desc = desc })
    end
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
        m_b(mode, lhs, rhs, nil, desc)
    end

    local float_namespace = vim.api.nvim_create_namespace 'tj_lsp_float'

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    map('n', '<leader>dh', vim.diagnostic.open_float, "Diagnostic Hover")
    map('n', '<leader>dk', vim.diagnostic.goto_prev, "Diagnostic Next")
    map('n', '<leader>dj', vim.diagnostic.goto_next, "Diagnostic Previous")
    map('n', '<leader>dp', vim.diagnostic.setqflist, "Diagnostics Populate")

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer

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
        m_b('n', 'gD', vim.lsp.buf.declaration, bufnr, "Go to Declaration")
        m_b('n', 'gd', vim.lsp.buf.definition, bufnr, "Go to Definition")

        m_b('n', 'K', vim.lsp.buf.hover, bufnr, "Hover")

        m_b('n', 'gi', vim.lsp.buf.implementation, bufnr, "Go to Implementation")
        m_b('n', 'gs', vim.lsp.buf.signature_help, bufnr, "Get Signature") -- "go type"
        m_b('n', 'gtd', vim.lsp.buf.type_definition, bufnr, "Go to Type Definition")
        m_b('n', '<leader>rn', vim.lsp.buf.rename, bufnr, "Rename")
        m_b('n', '<leader>da', vim.lsp.buf.code_action, bufnr, "Code Action")
        m_b('n', 'gr', vim.lsp.buf.references, bufnr, "Go to References")
        m_b('n', '<leader>df', function()
            -- vim.cmd("norm! mz")
            vim.lsp.buf.format { async = false }
            -- vim.cmd("norm! `z")
            -- vim.cmd("norm! zo")
        end, bufnr, "Format")
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
                    -- Source all of `runtimepath`
                    -- library = vim.api.nvim_get_runtime_file("", true), -- WARN: Very slow
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
        cmd = { "clangd", "--enable-config" } --, "--fallback-style=llvm"},
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

    vim.cmd("LspStart")
    -- cmp_setup()
end

M.spec = {
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = cmp_setup,
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                config = function()
                    lspconfig_setup()
                    vim.cmd.LspStart()
                end,
                event = 'LazyFile',
                dependencies = {
                    {
                        'williamboman/mason.nvim',
                        dependencies = 'williamboman/mason-lspconfig.nvim',
                        config = function()
                            require("mason").setup {}
                            require("mason-lspconfig").setup {
                                ensure_installed = {
                                    "lua_ls",
                                    "rust_analyzer",
                                    "bashls",
                                    "clangd",
                                    "cssls",
                                    "html",
                                    "jsonls",
                                    "jdtls",
                                    "tsserver",
                                    "marksman",
                                    "pyright",
                                    "vimls",
                                },
                                automatic_installation = false,
                            }
                        end,
                    },
                    { 'folke/neodev.nvim' },
                    { 'ray-x/lsp_signature.nvim' },
                    { 'simrat39/rust-tools.nvim' },
                },
            },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
            { 'onsails/lspkind.nvim' },
            { 'j-hui/fidget.nvim' },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = 'LazyFile',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require('null-ls')
            local sources = {
                -- python
                null_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length=120" }
                }),
                null_ls.builtins.formatting.isort,
            }

            null_ls.setup({ sources = sources })
        end,
    },
}

return M
