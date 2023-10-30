local colors = {
    foreground = '#e8dbb6',
    background = '#0e0f17',

    selection_fg = '#c1c1c1',
    selection_bg = '#403e3d',

    split = '#665c54',

    ansi = {
        '#353535',
        '#e75740',
        '#b8ba46',
        '#f0bf4f',
        '#89a498',
        '#c8899a',
        '#98be82',
        '#b4a998',
    },
    brights = {
        '#a09588',
        '#e75740',
        '#b8ba46',
        '#f0bf4f',
        '#89a498',
        '#c8899a',
        '#98be82',
        '#ece1c2',
    },
}
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
