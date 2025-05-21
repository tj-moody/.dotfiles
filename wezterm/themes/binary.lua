local colors = {
    foreground = '#ffffff',
    background = '#000000',

    selection_fg = '#ffffff',
    selection_bg = '#000000',

    split = '#ffffff',

    ansi = {
        '#ffffff',
        '#e75740',
        '#b8ba46',
        '#f0bf4f',
        '#89a498',
        '#c8899a',
        '#98be82',
        '#ffffff',
    },
    brights = {
        '#ffffff',
        '#e75740',
        '#b8ba46',
        '#f0bf4f',
        '#89a498',
        '#c8899a',
        '#98be82',
        '#ffffff',
    },
}
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
