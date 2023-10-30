local colors = {
    foreground = '#b3b1ad',
    background = '#080b10',

    selection_fg = '#b3b1ad',
    selection_bg = '#171e29',

    split = '#626a73',

    ansi = {
        '#02050c',
        '#f07178',
        '#c2d94c',
        '#ffb454',
        '#39bae6',
        '#cb9ff8',
        '#6fac98',
        '#c7c7c7',
    },
    brights = {
        '#676868',
        '#f07178',
        '#c2d94c',
        '#ffb454',
        '#39bae6',
        '#cb9ff8',
        '#6fac98',
        '#feffff',
    },
}
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
