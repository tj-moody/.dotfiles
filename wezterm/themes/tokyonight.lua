local colors = {
  foreground = '#bcc1dd',
  background = '#0e0f17',

  selection_fg = '#c9d1fb',
  selection_bg = '#333852',

  split = '#3b4261',

  ansi = {
    '#424765',
    '#e67d8f',
    '#63b29c',
    '#d8b072',
    '#83a0ec',
    '#b59bf0',
    '#64cae5',
    '#c1c9f1',
  },
  brights = {
    '#424765',
    '#e67d8f',
    '#63b29c',
    '#d8b072',
    '#83a0ec',
    '#b59bf0',
    '#64cae5',
    '#c1c9f1',
  },
}
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
