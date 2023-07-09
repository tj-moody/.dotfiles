local colors = {
  foreground = '#DCD7BA',
  background = '#1f1f28',

  cursor_bg = '#C8C093',
  cursor_fg = '#1d202f',

  selection_fg = '#C8C093',
  selection_bg = '#2D4F67',

  split = '#54546d',

  ansi = {
    '#090618',
    '#C34043',
    '#76946A',
    '#C0A36E',
    '#7E9CD8',
    '#957FB8',
    '#6A9589',
    '#C8C093',
  },
  brights = {
    '#727169',
    '#FF5D62',
    '#98BB6C',
    '#E5C384',
    '#7FB4CA',
    '#938AA9',
    '#7AA89F',
    '#DCD7BA',
  },

  -- -- Colors for copy_mode and quick_select
  -- -- available since: 20220807-113146-c2fee766
  -- -- In copy_mode, the color of the active text is:
  -- -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- -- 2. selection_* otherwise
  -- copy_mode_active_highlight_bg = { Color = '#000000' },
  -- -- use `AnsiColor` to specify one of the ansi color palette values
  -- -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  -- --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  -- copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  -- copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
  -- copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },
  --
  -- quick_select_label_bg = { Color = 'peru' },
  -- quick_select_label_fg = { Color = '#ffffff' },
  -- quick_select_match_bg = { AnsiColor = 'Navy' },
  -- quick_select_match_fg = { Color = '#ffffff' },
}

colors.scrollbar_thumb = colors.background
colors.cursor_border = colors.cursor_bg

return colors
