local colors = {
    name = "tokyonight",
    palette = {
        foreground = "#bcc1dd",
        background = "#0e0f17",

        selection_fg = "#c9d1fb",
        selection_bg = "#333852",

        split = "#3b4261",

        ansi = {
            "#424765",
            "#e67d8f",
            "#63b29c",
            "#d8b072",
            "#83a0ec",
            "#b59bf0",
            "#64cae5",
            "#c1c9f1",
        },
        brights = {
            "#424765",
            "#e67d8f",
            "#63b29c",
            "#d8b072",
            "#83a0ec",
            "#b59bf0",
            "#64cae5",
            "#c1c9f1",
        },
    },
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
