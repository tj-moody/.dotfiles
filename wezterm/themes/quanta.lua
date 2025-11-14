local colors = {
    name = "quanta",
    palette = {
        foreground = "#e0e0e0",
        -- background = "#080914",
        -- background = "#0d0e19",
        background = "#080712",

        selection_fg = "#c1c1c1",
        -- selection_bg = "#403e3d",
        selection_bg = "#1b1d29",

        split = "#665c54",

        ansi = {
            "#353535",
            "#ff4488",
            "#00ff99",
            "#f0bf4f",
            "#8ecfdc",
            "#c5a8e3",
            "#31a1a0",
            "#a5a5a5",
        },
        brights = {
            "#858585",
            "#ff4488",
            "#00ff99",
            "#f0bf4f",
            "#8ecfdc",
            "#c5a8e3",
            "#31a1a0",
            "#a5a5a5",
        },
    },
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
