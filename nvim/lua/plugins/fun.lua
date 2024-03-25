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
        event = 'VeryLazy',
    },
    {
        'RRethy/nvim-base16',
        cond = vim.g.have_fun,
        event = 'VeryLazy',
    },
    {
        'AlexvZyl/nordic.nvim',
        cond = vim.g.have_fun,
        event = 'VeryLazy',
    },
}

return M
