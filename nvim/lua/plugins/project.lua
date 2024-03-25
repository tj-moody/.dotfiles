local M = {}
M.spec = {
    {
        dir = '~/projects/projtasks.nvim',
        dependencies = { 'akinsho/toggleterm.nvim' },
        config = {
            terminal_config = {
                direction = "vertical",
            },
            output = "terminal",
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
