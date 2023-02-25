local M = {}

M.hltable = {
    noclownfiesta = {
        alpha = function()
            vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#bad7ff'})
            vim.api.nvim_set_hl(0, 'AlphaFooter1', { fg = '#b46958'})
        end,
    },
}

return M
