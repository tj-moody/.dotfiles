local colors = {
    foreground = '#ced5f1',
    background = '#1e1d2c',

    selection_fg = '#ced5f1',
    selection_bg = '#585a6e',

    split = '#6c7086',

    ansi = {
        '#454658',
        '#e490a7',
        '#b2e1a7',
        '#f5e2b4',
        '#91b2f4',
        '#ecc3e4',
        '#a5dfd5',
        '#bbc1db',
    },
    brights = {
        '#585a6e',
        '#e490a7',
        '#b2e1a7',
        '#f5e2b4',
        '#91b2f4',
        '#ecc3e4',
        '#a5dfd5',
        '#a7acc5',
    },
}
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
