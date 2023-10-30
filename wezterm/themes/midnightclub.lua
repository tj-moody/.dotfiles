local colors = {
    foreground = '#808080',
    background = '#0e0e12',

    selection_fg = '#808080',
    selection_bg = '#373f52',

    split = '#3c4654',

    ansi = {
        '#303f4e',
        '#fc735d',
        '#7cb375',
        '#ffae57',
        '#566370',
        '#908887',
        '#88d4ab',
        '#c9cba3',
    },
    brights = {
        '#373f52',
        '#fc735d',
        '#7cb375',
        '#ffae57',
        '#7c8692',
        '#908887',
        '#88d4ab',
        '#cfdbd5',
    },
}
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
