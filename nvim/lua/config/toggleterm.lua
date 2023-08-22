require('toggleterm').setup {
    open_mapping = [[<c-t>]],
    direction = 'float',
    highlights = {
        -- highlights which map to a highlight group
        -- name and a table of it's values
        -- NOTE: this is only a subset of values, any group
        -- placed here will be set for the terminal window split
        Normal = {
        },
        NormalFloat = {
            -- guibg = "#151515",
            guibg = vim.g.normalbg,
        },
        FloatBorder = {
            -- guibg = '#151515',
            -- guibg = '',
            guibg = vim.g.normalbg,
            guifg = vim.g.normalfg,
        },
    },
    shade_terminals = false,
    float_opts = {
        winblend = 0,
        border = 'single',
    },
}

local cursor_hl = { bg = vim.g.normalfg, fg = vim.g.normalbg }
vim.api.nvim_set_hl(0, 'TermCursor', cursor_hl)
vim.api.nvim_set_hl(0, 'TermCursorNC', cursor_hl)
