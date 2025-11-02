local colors = {
    name = "everforest",
    palette = {
        foreground = "#d0c6ad",
        background = "#343b42",

        selection_fg = "#d0c6ad",
        selection_bg = "#57404e",

        split = "#6e6f70",

        ansi = {
            "#343b42",
            "#d88382",
            "#abbf86",
            "#d5bd86",
            "#8cb9b2",
            "#cc9bb4",
            "#90be95",
            "#d0c6ad",
        },
        brights = {
            "#343b42",
            "#d88382",
            "#abbf86",
            "#d5bd86",
            "#8cb9b2",
            "#cc9bb4",
            "#90be95",
            "#d0c6ad",
        },
    },
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
