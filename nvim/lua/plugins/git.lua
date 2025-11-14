local M = {}
M.spec = {
    {
        "lewis6991/gitsigns.nvim",
        config = true,
        event = "LazyFile",
        keys = {
            { "<leader>gj", "<CMD>Gitsigns next_hunk<CR>", desc = "Next Change" },
            { "<leader>gk", "<CMD>Gitsigns prev_hunk<CR>", desc = "Prev Change" },
            { "<leader>gb", "<CMD>Gitsigns blame_line<CR>", desc = "Blame Line" },
            {
                "Cgb",
                -- Toggle git blame
                function()
                    vim.cmd("Gitsigns toggle_current_line_blame")
                end,
                desc = "Git Blame",
            },
        },
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
        keys = {
            {
                "<ldeader>gd",
                function()
                    if next(require("diffview.lib").views) == nil then
                        vim.cmd("DiffviewOpen")
                    else
                        vim.cmd("DiffviewClose")
                    end
                end,
                desc = "Git Diff",
            },
            {
                "<ldeader>gh",
                function()
                    if next(require("diffview.lib").views) == nil then
                        vim.cmd("DiffviewFileHistory")
                    else
                        vim.cmd("DiffviewClose")
                    end
                end,
                desc = "Git Diff",
            },
        },
        dependencies = "nvim-lua/plenary.nvim",
    },
    {
        "isakbm/gitgraph.nvim",
        config = {
            format = {
                timestamp = "%H:%M:%S %d-%m-%Y",
                fields = { "hash", "timestamp", "author", "branch_name", "tag" },
            },
        },
        keys = {
            {
                "<leader>gg",
                function()
                    vim.cmd.vsplit()
                    safe_require("gitgraph").draw({}, { all = true, max_count = 5000 })
                end,
                "Git Graph",
            },
        },
    },
}
return M
