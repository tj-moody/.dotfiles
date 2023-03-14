require('toggleterm').setup {
    highlights = {
        -- highlights which map to a highlight group name and a table of it's values
        -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        Normal = {
        },
        NormalFloat = {
            guibg = "#151515",
        },
        FloatBorder = {
            guibg = '#151515'
        },
    },
    shade_terminals = false,
    float_opts = {
        winblend = 10,
    },
}
-- local get_color = require('utils').get_color
-- vim.api.nvim_set_hl(0, 'TermCursor', { bg = get_color('Normal', 'fg#'), fg = '#000000' })

local cursor_hl = { bg = '#ffffff', fg = '#000000' }
vim.api.nvim_set_hl(0, 'TermCursor', cursor_hl)
vim.api.nvim_set_hl(0, 'TermCursorNC', cursor_hl)
