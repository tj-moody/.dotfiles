local M = {}
M.spec = {
    {
        "giusgad/pets.nvim",
        event = 'VeryLazy',
        dependencies = {
            "MunifTanjim/nui.nvim",
            "giusgad/hologram.nvim",
        },
        opts = {
            popup = { avoid_statusline = true },
        },
        cond = vim.g.have_fun,
    },
    {
        'RRethy/nvim-base16',
        event = 'VeryLazy',
        cond = vim.g.have_fun,
    },
    {
        'AlexvZyl/nordic.nvim',
        cond = vim.g.have_fun,
    },
}

return M
