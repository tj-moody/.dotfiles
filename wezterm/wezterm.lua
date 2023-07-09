local wezterm = require('wezterm')
local config = {}

config.font = wezterm.font(
    'FiraCode Nerd Font Mono',
    { weight = 'Light' }
)
config.font_size = 12
config.cell_width = 1
config.line_height = 1

local themes_list = {
    -- "noclownfiesta",
    "kanagawa",
    -- "kanagawa_dark",
    -- "gruvbox",
    -- "marsbox",
    -- "tokyonight",
    -- "oxocarbon",
    -- "catppuccin",
    -- "everforest",
}

local THEME = os.getenv("COLORS_NAME")
local valid_color = false
for _, v in ipairs(themes_list) do
    if v == THEME then
        valid_color = true
    end
end
if not valid_color then THEME = "kanagawa" end
config.colors = require('themes.' .. THEME)

config.window_background_opacity = 0.86
config.macos_window_background_blur = 39

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 35,
    right = 35,
    top = 35,
    bottom = 10,
}

config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
}

config.window_frame = {
    active_titlebar_bg = config.colors.background,
    inactive_titlebar_bg = config.colors.background,
}

-- wezterm.on('window-config-reloaded', function(window, pane)
-- end)

return config
