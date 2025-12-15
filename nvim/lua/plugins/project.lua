local M = {}

local function task(key, name, static)
    local cmd
    if static then
        cmd = function()
            safe_require("projtasks").static_runner(name)()
        end
    else
        cmd = function()
            safe_require("projtasks").persistent_runner(name)()
        end
    end
    return { key, cmd, desc = name }
end

M.spec = {
    {
        dir = "~/projects/projtasks.nvim",
        event = "LazyFile",
        keys = {
            {
                "<C-T>",
                function()
                    safe_require("projtasks").toggle()
                end,
                desc = "Toggle Terminal",
            },
            {
                "Cd",
                function()
                    safe_require("projtasks").toggle_terminal_direction()
                end,
                desc = "Terminal Direction",
            },
            {
                "Csd",
                function()
                    safe_require("projtasks").toggle_static_direction()
                end,
                desc = "Terminal Direction",
            },
            task("<leader>pr", "run"),
            task("<leader>pb", "build"),
            task("<leader>pt", "test"),
            task("<leader>pc", "cycle"),

            task("<leader>pR", "run", true),
            task("<leader>pB", "build", true),
            task("<leader>pT", "test", true),
            task("<leader>pC", "cycle", true),

            {
                "<leader>pe",
                function()
                    if vim.fn.filereadable("./projfile.lua") == 1 then
                        vim.cmd("edit ./projfile.lua")
                    else
                        print("No projfile in current directory.")
                    end
                end,
                desc = "Edit Projfile",
            },
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
