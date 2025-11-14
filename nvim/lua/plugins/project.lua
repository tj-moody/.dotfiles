local M = {}

local function task(key, name)
    return {
        key,
        function()
            require("projtasks").create_ptask_runner(name)()
        end,
        desc = name,
    }
end

M.spec = {
    {
        dir = "~/projects/projtasks.nvim",
        event = "LazyFile",
        keys = {
            {
                "<C-T>",
                function()
                    require("projtasks").toggle()
                end,
                desc = "Toggle Terminal",
            },
            {
                "Cd",
                function()
                    require("projtasks").toggle_terminal_direction()
                end,
                desc = "Terminal Direction",
            },
            task("<leader>pr", "run"),
            task("<leader>pb", "build"),
            task("<leader>pt", "test"),
            task("<leader>pB", "bench"),
            task("<leader>pP", "profile"),
            task("<leader>pc", "cycle"),
        },
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
