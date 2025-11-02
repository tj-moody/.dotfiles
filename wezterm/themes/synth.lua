local colors = {
    name = "synth",
    palette = {
        foreground = "#e0e0e0",
        background = "#0d0e19",

        selection_fg = "#e0e0e0",
        selection_bg = "#10141c",

        split = "#e0e0e0",

        ansi = {
            "#424765",
            "#ff5572",
            "#25d88a",
            "#ffee55",
            "#55b4ff",
            "#c779ff",
            "#64cae5",
            "#6a788e",
        },
        brights = {
            "#5F6978",
            "#ff5572",
            "#25d88a",
            "#ffee55",
            "#55b4ff",
            "#c779ff",
            "#64cae5",
            "#AEC0D1",
        },
    },
}
colors.palette.cursor_bg = colors.palette.foreground
colors.palette.cursor_fg = colors.palette.background

colors.palette.scrollbar_thumb = colors.palette.background
colors.palette.cursor_border = colors.palette.cursor_bg

return colors
-- primary = "#00FF9C",
-- surface = "#10141C",
-- text_100 = "#E0E0E0",
-- text_200 = "#CFCFCF",
-- text_300 = "#a8a8a8",
-- text_400 = "#828282",
-- gray_500 = "#5F6978",
-- gray_300 = "#6A7B8E",
-- gray_200 = "#8B9DAF",
-- gray_100 = "#AEC0D1",
-- steel = "#3A4A5C",
-- red = "#ff5572",
-- yellow = "#ffee55",
-- blue = "#55b4ff",
-- green = "#25D88A",
-- orange = "#ff9900",
-- purple = "#c779ff",
-- brown = "#D2691E",
-- azure = "#4d7bff",
-- cyan = "#00e5ff",
