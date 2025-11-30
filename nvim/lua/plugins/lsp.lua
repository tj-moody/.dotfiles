local M = {}

local window_title = "  "
local function lsp_setup()
    local m_b = function(mode, lhs, rhs, buff, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = buff, desc = desc })
    end
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
        m_b(mode, lhs, rhs, nil, desc)
    end

    map("n", "<leader>dh", vim.diagnostic.open_float, "Diagnostic Hover")
    map("n", "<leader>dk", function()
        vim.diagnostic.jump({ count = -1 })
    end, "Diagnostic Prev")
    map("n", "<leader>dj", function()
        vim.diagnostic.jump({ count = 1 })
    end, "Diagnostic Next")
    map("n", "<leader>dp", vim.diagnostic.setqflist, "Diagnostics Populate")

    local on_attach = function(_, bufnr)
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        m_b("n", "K", function()
            vim.lsp.buf.hover({ border = "rounded", title = window_title })
        end, bufnr, "Hover")

        m_b("n", "gD", vim.lsp.buf.declaration, bufnr, "Go to Declaration")
        m_b("n", "gd", vim.lsp.buf.definition, bufnr, "Go to Definition")

        m_b("n", "gi", vim.lsp.buf.implementation, bufnr, "Go to Implementation")
        m_b("n", "gs", vim.lsp.buf.signature_help, bufnr, "Get Signature") -- "go type"
        m_b("n", "gtd", vim.lsp.buf.type_definition, bufnr, "Go to Type Definition")
        m_b("n", "<leader>rn", vim.lsp.buf.rename, bufnr, "Rename")
        m_b("n", "<leader>da", vim.lsp.buf.code_action, bufnr, "Code Action")
        m_b("n", "gr", vim.lsp.buf.references, bufnr, "Go to References")
        m_b("n", "<leader>df", function()
            safe_require("conform").format({ bufnr = bufnr })
            vim.cmd.write()
        end, bufnr, "Format")
    end
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            on_attach(_, ev.bufnr)
        end,
    })

    safe_require("lazydev").setup({
        library = {
            plugins = { "neotest" },
        },
    })

    vim.lsp.config("*", {
        capabilities = {
            textDocument = {
                semanticTokens = {
                    multilineTokenSupport = true,
                },
            },
        },
        root_markers = { ".git" },
    })

    vim.lsp.config.verible = {
        cmd = { "verible-verilog-ls", "--rules_config_search" },
    }

    vim.lsp.enable({
        "ruff",
        "ts_ls",
        "lua_ls",
        "pyrefly",
        "bashls",
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
        "verible",
    })
end

local blink_opts = {
    fuzzy = {
        implementation = "prefer_rust_with_warning",
    },
    cmdline = { enabled = false },
    sources = {
        default = { "lazydev", "lsp", "buffer", "path" },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
        },
    },
    completion = {
        accept = {
            auto_brackets = { enabled = false },
        },
        list = {
            selection = {
                preselect = false,
            },
        },
        ghost_text = {
            enabled = true,
            show_without_selection = true,
        },
        trigger = {
            show_on_backspace = false,
        },
        menu = {
            border = "none",
            direction_priority = { "s" },
            draw = {
                columns = { { "kind_icon" }, { "label" }, { "kind" }, { "source_name" } },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local icon = ctx.kind_icon
                            icon = safe_require("lspkind").symbolic(ctx.kind, {
                                mode = "symbol",
                            })
                            return icon .. ctx.icon_gap
                        end,
                    },
                    label = {
                        width = { fill = true, max = 60 },
                        text = function(ctx)
                            return safe_require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return safe_require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                },
            },
        },
        -- NOTE: Currently no option for title on documentation window
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
        },
    },
    keymap = {
        preset = "none",
        ["<CR>"] = {
            function(cmp)
                if not cmp.is_visible() then
                    return nil
                end
                local item = cmp.get_selected_item()
                if not item then
                    return nil
                end
                if not vim.tbl_contains({ 2, 3, 4 }, item.kind) then
                    return cmp.accept()
                end
                vim.api.nvim_feedkeys("(", "m", false)
                return true
            end,
            "fallback",
        },
        ["<Tab>"] = {
            "select_next",
            "fallback",
        },
        ["<S-Tab>"] = {
            "select_prev",
            "fallback",
        },
        ["<C-N>"] = {
            "snippet_forward",
            "fallback",
        },
        ["<C-P>"] = {
            "snippet_backward",
            "fallback",
        },
        ["<C-Space>"] = { "show", "fallback" },
    },
    signature = { enabled = true },
}

local web_conform_options = { "prettier", "prettierd", stop_after_first = true }

M.spec = {
    {
        "neovim/nvim-lspconfig",
        config = lsp_setup,
        event = { "BufReadPre", "BufNew" },
        dependencies = {
            { "mrcjkb/rustaceanvim" },
            { "j-hui/fidget.nvim" },
            { "folke/lazydev.nvim" },
            {
                "mason-org/mason.nvim",
                config = true,
            },
        },
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        config = blink_opts,
        event = "LazyFile",
        priority = 1000,
        dependencies = {
            { "onsails/lspkind.nvim" },
            { "xzbdmw/colorful-menu.nvim" },
        },
    },
    {
        "stevearc/conform.nvim",
        event = "LazyFile",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            safe_require("conform").setup({
                default_format_opts = {
                    lsp_format = "fallback",
                },
                formatters = {
                    verible_verilog_format = {
                        command = "verible-verilog-format",
                        args = { "--indentation_spaces=4", "-" },
                        stdin = true,
                    },
                },

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
                    verilog = { "verible_verilog_format" },
                },
            })
        end,
    },
}

return M
