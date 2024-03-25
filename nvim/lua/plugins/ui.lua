local M = {}
M.spec = {
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require('fidget').setup {
                text = {
                    spinner = "arc",         -- animation shown when tasks are ongoing
                    done = "✔",            -- character shown when all tasks are complete
                    commenced = "Started",   -- message shown when task starts
                    completed = "Completed", -- message shown when task completes
                },
                align = {
                    bottom = true, -- align fidgets along bottom edge of buffer
                    right = true,  -- align fidgets along right edge of buffer
                },
                timer = {
                    spinner_rate = 125,  -- frame rate of spinner animation, in ms
                    fidget_decay = 2000, -- how long to keep around empty fidget, in ms
                    task_decay = 1000,   -- how long to keep around completed task, in ms
                },
                window = {
                    relative = "win", -- where to anchor, either "win" or "editor"
                    blend = 0,        -- &winblend for the window
                    zindex = nil,     -- the zindex value for the window
                    border = "none",  -- style of border for the fidget window
                },
                fmt = {
                    leftpad = true,        -- right-justify text in fidget box
                    stack_upwards = false, -- list of tasks grows upwards
                    max_width = 0,         -- maximum width of the fidget box
                    fidget =               -- function to format fidget title
                        function(fidget_name, spinner)
                            return string.format("%s %s", spinner, fidget_name)
                        end,
                    task = -- function to format each task line
                        function(task_name, message, percentage)
                            return string.format(
                                "%s%s [%s]",
                                message,
                                percentage and string.format(" (%s%%)", percentage) or "",
                                task_name
                            )
                        end,
                },
                debug = {
                    logging = false, -- whether to enable logging, for debugging
                    strict = false,  -- whether to interpret LSP strictly
                },
            }

            local clear_hl_bg = safe_require('plugins.colorscheme').clear_hl_bg
            clear_hl_bg('FidgetTitle')
            clear_hl_bg('FidgetTask')
            vim.api.nvim_set_hl(0, 'FidgetTask', {
                fg = safe_require('plugins.colorscheme').get_color('NormalFloat', 'fg#'),
            })
        end
    },
    {
        'folke/which-key.nvim',
        event = 'LazyFile',
        config = function()
            require('which-key').setup {}

            require('which-key').register {
                ["<leader>"] = {
                    ["f"] = { name = "+find", },
                    ["c"] = { name = "+comment", },
                    ["d"] = { name = "+diagnostics", },
                    ["g"] = { name = "+git", },
                    ["l"] = { name = "+lazy", },
                    ["p"] = { name = "+project", },
                    ["r"] = { name = "Rename", },
                    ["t"] = { name = "Tabs", },
                    ["b"] = { name = "Buffer", },
                    ["."] = "Fuzzy Split",
                    ["R"] = "Restart Vim",
                    ["y"] = "System Yank",
                    ["="] = "Align File",
                    ["o"] = "Only Window",
                    ["O"] = "Only Buffer",
                    ["q"] = "Quit",
                    [","] = {
                        name = "meta",
                        ["p"] = { name = "profiling", },
                    },
                    ["z"] = { name = "Zen Mode" },
                    ["C"] = { name = "Comment and Copy" },
                    ["x"] = { name = "QF List", },
                },
                ["C"] = {
                    ["l"] = { name = "lsp-lines, verbose lualine", },
                    ["r"] = { name = "relative number", },
                    ["w"] = { name = "wrap" },
                    ["b"] = { name = "bufferline show all", },
                    ["i"] = { name = "inlay hints", },
                    ["c"] = { name = "colorcolumn, conceallevel, colorscheme", },
                    ["v"] = { name = "virtual edit", },
                    ["g"] = { name = "git blame", },
                    ["t"] = { name = "theme" },
                    ["d"] = { name = "terminal direction"}
                },
                ["g"] = { name = "Go", },
                ["<SPACE>"] = { name = "Move Window", },
                ["d"] = { name = "Diagnostics", },
                ["s"] = { name = "Splits", },
            }
        end,
    },
    {
        'folke/todo-comments.nvim',
        event = 'LazyFile',
        config = {
            highlight = { multiline = true },
            keywords = {
                ["DONE"] = { icon = " ", color = "#b8bb26", },
                ["TODO"] = { icon = " ", color = "info" },
                ["DEBUG"] = { icon = " ", color = "#a454ff" },
                ["DEBUG_ONLY"] = { icon = " ", color = "#a454ff" },
            },
        },
    },
    {
        'yorickpeterse/nvim-pqf',
        event = 'LazyFile',
        config = true,
    },
}

return M
