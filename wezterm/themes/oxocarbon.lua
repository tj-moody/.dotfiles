local colors = {
    foreground = '#f2f3f7',
    background = '#161616',

    selection_fg = '#b6b7ba',
    selection_bg = '#292929',

    split = '#6e6f70',

    ansi = {
        '#161616',
        '#dc5e94',
        '#5bbb72',
        '#55bab8',
        '#82a7f8',
        '#c2a6f9',
        '#80dddd',
        '#dfdedf',
    },
    brights = {
        '#292929',
        '#dc5e94',
        '#5bbb72',
        '#55bab8',
        '#82a7f8',
        '#c2a6f9',
        '#80dddd',
        '#dfdedf',
    },
}
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
