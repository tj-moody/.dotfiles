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
            require('which-key').setup {
                { "<SPACE>", group = "Move Window" },
                { "<leader>,", group = "meta" },
                { "<leader>,p", group = "profiling" },
                { "<leader>.", desc = "Fuzzy Split" },
                { "<leader>=", desc = "Align File" },
                { "<leader>C", group = "Comment and Copy" },
                { "<leader>O", desc = "Only Buffer" },
                { "<leader>R", desc = "Restart Vim" },
                { "<leader>b", group = "Buffer" },
                { "<leader>c", group = "comment" },
                { "<leader>d", group = "diagnostics" },
                { "<leader>f", group = "find" },
                { "<leader>g", group = "git" },
                { "<leader>l", group = "lazy" },
                { "<leader>o", desc = "Only Window" },
                { "<leader>p", group = "project" },
                { "<leader>q", desc = "Quit" },
                { "<leader>r", group = "Rename" },
                { "<leader>t", group = "Tabs" },
                { "<leader>x", group = "QF List" },
                { "<leader>y", desc = "System Yank" },
                { "<leader>z", group = "Zen Mode" },
                { "Cb", group = "bufferline show all" },
                { "Cc", group = "colorcolumn, conceallevel, colorscheme" },
                { "Cd", group = "terminal direction" },
                { "Cg", group = "git blame" },
                { "Ci", group = "inlay hints" },
                { "Cl", group = "lsp-lines, verbose lualine" },
                { "Cr", group = "relative number" },
                { "Ct", group = "theme" },
                { "Cv", group = "virtual edit" },
                { "Cw", group = "wrap" },
                { "d", group = "Diagnostics" },
                { "g", group = "Go" },
                { "s", group = "Splits" },
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
