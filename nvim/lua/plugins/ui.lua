local M = {}
M.spec = {
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
            safe_require("fidget").setup({
                text = {
                    spinner = "arc",
                },
                window = {
                    blend = 0,
                },
                fmt = {
                    stack_upwards = false,
                },
            })

            local clear_hl_bg = safe_require("plugins.colorscheme").clear_hl_bg
            clear_hl_bg("FidgetTitle")
            clear_hl_bg("FidgetTask")
        end,
    },
    {
        "folke/which-key.nvim",
        event = "LazyFile",
        config = function()
            safe_require("which-key").setup({})
            safe_require("which-key").add({
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
            })
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "LazyFile",
        config = {
            highlight = { multiline = true },
            keywords = {
                ["DONE"] = { icon = " ", color = "hint" },
                ["TODO"] = { icon = " ", color = "info" },
                ["DEBUG"] = { icon = " ", color = "#a454ff" },
                ["DEBUG_ONLY"] = { icon = " ", color = "#a454ff" },
                ["SPEC"] = { icon = "󱔗 ", color = "#B3E5FC" },
                ["PASS"] = { icon = " ", color = "#EFEFBF" },
            },
        },
    },
}

return M
