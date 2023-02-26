require('toggleterm').setup {
    highlights = {
        -- highlights which map to a highlight group name and a table of it's values
        -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
        Normal = {
            guibg = "#151515",
        },
        NormalFloat = {
            link = 'Normal'
            -- guibg = "#151515",
        },
    },
    shade_terminals = false,
}
