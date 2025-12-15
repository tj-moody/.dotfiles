local colors = {
    name = "oxocarbon",
    palette = {
        foreground = "#f2f3f7",
        background = "#0e0e0e",

        selection_fg = "#b6b7ba",
        selection_bg = "#292929",

        split = "#6e6f70",

        ansi = {
            "#161616",
            "#dc5e94",
            "#5bbb72",
            "#55bab8",
            "#82a7f8",
            "#c2a6f9",
            "#80dddd",
            "#dfdedf",
        },
        brights = {
            "#292929",
            "#dc5e94",
            "#5bbb72",
            "#55bab8",
            "#82a7f8",
            "#c2a6f9",
            "#80dddd",
            "#dfdedf",
        },
    },
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
