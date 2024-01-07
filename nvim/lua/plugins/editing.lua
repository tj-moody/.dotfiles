local M = {}
M.spec = {
    {
        'tpope/vim-surround',
        event = 'VeryLazy',
    },
    {
        'rmagatti/auto-session',
        lazy = not vim.g.tj_reloaded,
        cmd = { 'SessionRestore', 'SessionSave' },
        config = function()
            require('auto-session').setup({ ---@diagnostic disable-line
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
                session_lens = { load_on_setup = false, },
            })
            if vim.g.tj_reloaded then
                vim.cmd.SessionRestore()
            end
        end,
    },
    {
        dir = "~/projects/nucomment.nvim",
        config = { floating_comments = false },
        event = "VeryLazy",
    },
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        config = function()
            require("nvim-autopairs").setup {
                map_bs = false,
                disable_filetype = { "TelescopePrompt", "text" }
            }
            vim.opt.formatoptions = "rjql"
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = {
            ["*"] = { names = false },
            rust = { names = false },
        },
    },
    {
        'chrisgrieser/nvim-various-textobjs',
        event = 'VeryLazy',
        config = function()
            local to = require('various-textobjs')
            to.setup({ useDefaultKeymaps = false })
            local map = vim.keymap.set

            map({ "o", "x" }, "as", function() to.subword("outer") end)
            map({ "o", "x" }, "is", function() to.subword("inner") end)

            map({ "o", "x" }, "ad", function() to.doubleSquareBrackets("outer") end)
            map({ "o", "x" }, "id", function() to.doubleSquareBrackets("inner") end)

            map({ "o", "x" }, "gG", function() to.entireBuffer() end)
        end
    },
    {
        'RaafatTurki/hex.nvim',
        event = 'VeryLazy',
        config = true,
    },
    {
        'tommcdo/vim-lion',
        event = 'VeryLazy',
    },
    {
        'rmagatti/alternate-toggler',
        cmd = { 'ToggleAlternate' },
        config =
        {
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
            }
        }
    },
    {
        'willothy/flatten.nvim',
        config = { window = { open = 'alternate' }, },
        priority = 1001,
        lazy = false,
    },
    {
        'chomosuke/term-edit.nvim',
        event = 'VeryLazy',
        version = '1.*',
        config = {
            prompt_end = ':: ',
        }
    },
    {
        'yuttie/comfortable-motion.vim',
        event = 'VeryLazy',
    },
    {
        "folke/trouble.nvim",
        event = 'VeryLazy',
        config = true,
    },
    {
        'willothy/wezterm.nvim',
        event = 'VeryLazy',
        config = true
    },
    {
        'mrjones2014/smart-splits.nvim',
        dependencies = { { 'numToStr/Navigator.nvim', config = true } },
        event = 'VeryLazy',
        config = {
            -- During resize
            ignored_filetypes = {
                'nofile',
                'quickfix',
                'prompt',
            },
            ignored_events = {
                'BufEnter',
                'WinEnter',
            },
            ignored_buftypes = { 'NvimTree' },
            default_amount = 3,
            resize_mode = {
                quit_key = '<ESC>',
                resize_keys = { 'h', 'j', 'k', 'l' },
                silent = true,
                hooks = {
                    on_enter = nil,
                    on_leave = nil,
                },
            },

            move_cursor_same_row = false,

            multiplexer_integration = true,
            disable_multiplexer_nav_when_zoomed = true,
            at_edge = function(args)
                ({
                    ["left"] = vim.cmd.NavigatorLeft,
                    ["right"] = vim.cmd.NavigatorRight,
                    ["up"] = vim.cmd.NavigatorUp,
                    ["down"] = vim.cmd.NavigatorDown,
                })[args.direction]()
            end,
        }
    },
}
return M
