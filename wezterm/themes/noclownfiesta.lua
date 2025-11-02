local colors = {
    name = "noclownfiesta",
    palette = {
        foreground = "#e1e1e1",
        background = "#141414",

        selection_fg = "#c1c1c1",
        selection_bg = "#403e3d",

        split = "#727272",

        ansi = {
            "#353535",
            "#a96c5b",
            "#94a862",
            "#f2a965",
            "#8296a9",
            "#b57b96",
            "#a5b4bf",
            "#b4a998",
        },
        brights = {
            "#a09588",
            "#a96c5b",
            "#94a862",
            "#f2a965",
            "#8296a9",
            "#d29daa",
            "#a5b4bf",
            "#ece1c2",
        },
    }
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
