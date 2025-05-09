local M = {}
M.spec = {
    {
        "lewis6991/gitsigns.nvim",
        config = true,
        event = "LazyFile",
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
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
        event = "LazyFile",
    },
}
return M
