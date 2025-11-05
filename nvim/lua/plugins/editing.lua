local M = {}
M.spec = {
    {
        "tpope/vim-surround",
        event = "LazyFile",
    },
    {
        "rmagatti/auto-session",
        lazy = false,
        cmd = { "SessionRestore", "SessionSave" },
        config = function()
            require("auto-session").setup({ ---@diagnostic disable-line
                auto_save_enabled = false,
                auto_restore_enabled = false,
                log_level = "error",
                auto_session_suppress_dirs = {
                    "~/",
                    "~/Projects",
                    "~/Downloads",
                    "/",
                },

                -- Don't load telescope on startup
                session_lens = { load_on_setup = false },
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                map_bs = false,
                disable_filetype = { "TelescopePrompt", "text" },
            })
            vim.opt.formatoptions = "rjql"
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "LazyFile",
        config = {
            ["*"] = { names = false },
            rust = { names = false },
        },
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        event = "BufEnter",
        config = function()
            local to = require("various-textobjs")
            to.setup({ useDefaultKeymaps = false })
            local map = vim.keymap.set

            map({ "o", "x" }, "as", function()
                to.subword("outer")
            end)
            map({ "o", "x" }, "is", function()
                to.subword("inner")
            end)

            map({ "o", "x" }, "ad", function()
                to.doubleSquareBrackets("outer")
            end)
            map({ "o", "x" }, "id", function()
                to.doubleSquareBrackets("inner")
            end)

            map({ "o", "x" }, "gG", function()
                to.entireBuffer()
            end)
        end,
    },
    {
        "tommcdo/vim-lion",
        keys = {
            { "gl", mode = "x" },
            { "gL", mode = "x" },
        },
    },
    {
        "rmagatti/alternate-toggler",
        cmd = { "ToggleAlternate" },
        config = {
            alternates = {
                ["true"] = "false",
                ["True"] = "False",
                ["TRUE"] = "FALSE",
                ["Yes"] = "No",
                ["YES"] = "NO",
                ["1"] = "0",

                -- Use logical opposites for comparisons;
                -- > && <=, for example, are complementary,
                -- and encompass all cases
                ["<"] = ">=",
                [">"] = "<=",
                -- [">="] = "<",
                -- ["<="] = ">",

                -- Alternatively,
                -- ["<"] = ">",

                ["("] = ")",
                ["["] = "]",
                ["{"] = "}",
                ['"'] = "'",
                ['""'] = "''",
                ["+"] = "-",
                ["==="] = "!==",
                ["=="] = "!=",
                -- ["~="] = "==",
                ["++"] = "--",
                ["+="] = "-=",
                ["&&"] = "||",
            },
        },
    },
    {
        "willothy/flatten.nvim",
        config = { window = { open = "alternate" } },
        lazy = true,
    },
    {
        "chomosuke/term-edit.nvim",
        ft = "projterm",
        version = "1.*",
        config = {
            prompt_end = ":: ",
        },
    },
    {
        "yuttie/comfortable-motion.vim",
        event = "LazyFile",
    },
    {
        "aserowy/tmux.nvim",
        event = "LazyFile",
        config = {
            navigation = {
                cycle_navigation = false,
            },
        },
    },
}
return M
