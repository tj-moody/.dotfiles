local M = {}

local function cmp_setup()
    local luasnip = require("luasnip")
    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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

    local cmp = require("cmp")

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
        mapping = cmp.mapping.preset.cmdline({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            -- ['<C-Space>'] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.confirm({ select = false }),
            -- Accept currently selected item. Set `select`
            -- to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
        }, {
            { name = "luasnip", keyword_length = 3 }, -- For luasnip users.
            { name = "path" },
        }, {
            { name = "buffer" },
            -- { name = 'cmdline' },
        }),
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
    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            -- You can specify the `cmp_git` source if you were installed it.
            { name = "cmp_git" },
        }, {
            { name = "buffer" },
        }),
    })

    -- Use buffer source for `/` and `?`
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':'
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end

local window_title = "  "
local function lspconfig_setup()
    local m_b = function(mode, lhs, rhs, buff, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = buff, desc = desc })
    end
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
        m_b(mode, lhs, rhs, nil, desc)
    end

    local float_namespace = vim.api.nvim_create_namespace("tj_lsp_float")

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    map("n", "<leader>dh", vim.diagnostic.open_float, "Diagnostic Hover")
    map("n", "<leader>dk", vim.diagnostic.goto_prev, "Diagnostic Next")
    map("n", "<leader>dj", vim.diagnostic.goto_next, "Diagnostic Previous")
    map("n", "<leader>dp", vim.diagnostic.setqflist, "Diagnostics Populate")

    local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        require("lsp_signature").on_attach({
            hint_scheme = "Normal",
            hint_prefix = " ",
            bind = true,
            handler_opts = {
                border = "rounded",
            },
        }, bufnr)

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        m_b("n", "gD", vim.lsp.buf.declaration, bufnr, "Go to Declaration")
        m_b("n", "gd", vim.lsp.buf.definition, bufnr, "Go to Definition")

        -- m_b("n", "K", vim.lsp.buf.hover, bufnr, "Hover")

        m_b("n", "gi", vim.lsp.buf.implementation, bufnr, "Go to Implementation")
        m_b("n", "gs", vim.lsp.buf.signature_help, bufnr, "Get Signature") -- "go type"
        m_b("n", "gtd", vim.lsp.buf.type_definition, bufnr, "Go to Type Definition")
        m_b("n", "<leader>rn", vim.lsp.buf.rename, bufnr, "Rename")
        m_b("n", "<leader>da", vim.lsp.buf.code_action, bufnr, "Code Action")
        m_b("n", "gr", vim.lsp.buf.references, bufnr, "Go to References")
        m_b("n", "<leader>df", function()
            require("conform").format({ bufnr = bufnr })
        end, bufnr, "Format")
    end
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            on_attach(_, ev.bufnr)
        end,
    })

    require("lazydev").setup({
        library = {
            plugins = { "neotest" },
        },
    })

    vim.lsp.config.lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "P", "safe_require" },
                    disable = { "lowercase-global" },
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
                    version = "LuaJIT",
                },
            },
        },
    }
    vim.lsp.config.clangd = {
        cmd = { "clangd", "--enable-config" }, --, "--fallback-style=llvm"},
    }
    vim.lsp.enable({
        "ruff",
        "ts_ls",
        "lua_ls",
        "pyright",
        "bash_ls",
        "clangd",
        "cssls",
        "html",
        "jdtls",
        "jsonls",
        "marksman",
        "vimls",
        "asm_lsp",
        "texlab",
        "gopls",
        "rustaceanvim",
    })

    vim.cmd.LspStart()
end

local web_conform_options = { "prettier", "prettierd", stop_after_first = true }

M.spec = {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = cmp_setup,
        dependencies = {
            {
                "neovim/nvim-lspconfig",
                config = function()
                    lspconfig_setup()
                end,
                event = "LazyFile",
                dependencies = {
                    {
                        "mason-org/mason.nvim",
                        config = function()
                            require("mason").setup({})
                        end,
                    },
                    { "folke/lazydev.nvim" },
                    { "ray-x/lsp_signature.nvim" },
                    { "mrcjkb/rustaceanvim" },
                    { "j-hui/fidget.nvim" },
                },
            },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },
            { "onsails/lspkind.nvim" },
        },
    },
    {
        "stevearc/conform.nvim",
        event = "LazyFile",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = {
                        "stylua",
                        env = {
                            indent_type = "spaces",
                        },
                    },
                    python = { "ruff", "black" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    javascript = web_conform_options,
                    typescript = web_conform_options,
                    typescriptreact = web_conform_options,
                    javascriptreact = web_conform_options,
                    html = web_conform_options,
                    css = web_conform_options,
                    go = { "goimports", "gofmt" },
                    cpp = { "clang-format" },
                    c = { "clang-format" },
                },
            })
        end,
    },
}

return M
