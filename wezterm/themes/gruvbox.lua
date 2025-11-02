local colors = {
    name = "gruvbox",
    palette = {
        foreground = "#e8dbb6",
        background = "#111122",

        selection_fg = "#c1c1c1",
        selection_bg = "#403e3d",

        split = "#665c54",

        ansi = {
            "#353535",
            "#e75740",
            "#b8ba46",
            "#f0bf4f",
            "#89a498",
            "#c8899a",
            "#98be82",
            "#b4a998",
        },
        brights = {
            "#a09588",
            "#e75740",
            "#b8ba46",
            "#f0bf4f",
            "#89a498",
            "#c8899a",
            "#98be82",
            "#ece1c2",
        },
    },
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
