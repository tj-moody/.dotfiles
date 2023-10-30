local colors = {
    foreground = '#d0c6ad',
    background = '#343b42',

    selection_fg = '#d0c6ad',
    selection_bg = '#57404e',

    split = '#6e6f70',

    ansi = {
        '#343b42',
        '#d88382',
        '#abbf86',
        '#d5bd86',
        '#8cb9b2',
        '#cc9bb4',
        '#90be95',
        '#d0c6ad',
    },
    brights = {
        '#343b42',
        '#d88382',
        '#abbf86',
        '#d5bd86',
        '#8cb9b2',
        '#cc9bb4',
        '#90be95',
        '#d0c6ad',
    },
}
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
