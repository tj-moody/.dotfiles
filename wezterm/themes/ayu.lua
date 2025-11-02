local colors = {
    name = "ayu",
    palette = {
        foreground = "#b3b1ad",
        background = "#0a0e14",

        selection_fg = "#b3b1ad",
        selection_bg = "#171e29",

        split = "#626a73",

        ansi = {
            "#02050c",
            "#f07178",
            "#c2d94c",
            "#ffb454",
            "#39bae6",
            "#cb9ff8",
            "#6fac98",
            "#c7c7c7",
        },
        brights = {
            "#676868",
            "#f07178",
            "#c2d94c",
            "#ffb454",
            "#39bae6",
            "#cb9ff8",
            "#6fac98",
            "#feffff",
        },
    },
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
