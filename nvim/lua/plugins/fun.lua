local M = {}
M.spec = {
    {
        "giusgad/pets.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "giusgad/hologram.nvim",
        },
        opts = {
            popup = { avoid_statusline = true },
        },
        cond = vim.g.have_fun,
        event = "LazyFile",
        priority = -1000,
    },
}

return M
