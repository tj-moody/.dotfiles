local M = {}
M.spec = {
    {
        dir = "~/projects/projtasks.nvim",
        config = {
            terminal_config = {
                direction = "horizontal",
            },
            defaults = {
                ["rust"] = {
                    ["build"] = [[cargo build]],
                    ["run"] = [[cargo run]],
                    ["test"] = [[cargo nextest run]],
                },
            },
        },
    },
}

return M
