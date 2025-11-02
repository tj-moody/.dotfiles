local colors = {
    name = "catppuccin",
    palette = {
        foreground = "#ced5f1",
        background = "#11111b",
        -- background = "#1e1d2c",

        selection_fg = "#ced5f1",
        selection_bg = "#585a6e",

        split = "#6c7086",

        ansi = {
            "#454658",
            "#e490a7",
            "#b2e1a7",
            "#f5e2b4",
            "#91b2f4",
            "#ecc3e4",
            "#a5dfd5",
            "#bbc1db",
        },
        brights = {
            "#585a6e",
            "#e490a7",
            "#b2e1a7",
            "#f5e2b4",
            "#91b2f4",
            "#ecc3e4",
            "#a5dfd5",
            "#a7acc5",
        },
    },
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
