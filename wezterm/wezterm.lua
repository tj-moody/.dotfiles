local wezterm = require('wezterm') or {}
local config = {}

-- config.font = wezterm.font_with_fallback(
--     {
--         family = 'FiraCode',
--         weight = 'Regular',
--     },
--     {
--         family = 'FiraCode NFM',
--         weight = 'Bold',
--     }
-- )
config.font = wezterm.font(
    'FiraCode NFM',
    {
        weight = 'Regular',
    }
)
config.font_size = 11
config.cell_width = 1
config.line_height = 1
config.bold_brightens_ansi_colors = "BrightAndBold"
config.freetype_render_target = "HorizontalLcd"
-- TURN OFF LIGATURES
-- config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}

-- TODO: Update pending
-- https://github.com/wez/wezterm/issues/4610
-- config.underline_thickness = 3
config.underline_position = -4

local themes_list = {
    "noclownfiesta",
    "kanagawa",
    "gruvbox",
    "tokyonight",
    "oxocarbon",
    "catppuccin",
    "everforest",
    "ayu",
    "midnightclub",
    "binary",
}

local function read_theme()
    local theme_file = io.open("/Users/tj/.dotfiles/.theme.txt", "r")
    if not theme_file then
        wezterm.log_info("error reading file")
        return "gruvbox"
    end
    io.input(theme_file)
    local theme = io.read()
    io.close(theme_file)
    local valid_color = false
    for _, v in ipairs(themes_list) do
        if v == theme then
            valid_color = true
        end
    end
    if not valid_color then theme = "gruvbox" end
    return theme
end
local THEME = read_theme()
config.colors = require('themes.' .. THEME)

config.window_background_opacity = 1
config.macos_window_background_blur = 39

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.colors.tab_bar = {
    active_tab = {
        bg_color = config.colors.background,
        fg_color = config.colors.foreground,
    }
}
config.colors.tab_bar.inactive_tab = config.colors.tab_bar.active_tab
config.colors.tab_bar.inactive_tab_hover = config.colors.tab_bar.active_tab
config.colors.tab_bar.new_tab = config.colors.tab_bar.active_tab
config.colors.tab_bar.new_tab_hover = config.colors.tab_bar.active_tab

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


local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
    Left  = 'h', h = 'Left',
    Down  = 'j', j = 'Down',
    Up    = 'k', k = 'Up',
    Right = 'l', l = 'Right',
}

local function split_nav(key)
    return {
        key = key, mods = 'CTRL',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({ SendKey = { key = key, mods = 'CTRL' }, }, pane)
            else
                win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
            end
        end),
    }
end

config.keys = {
    -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the tab
    {
        key = 'u',
        mods = 'CMD',
        action = wezterm.action_callback(function(window, _)
            local overrides = window:get_config_overrides() or {}
            if not overrides.window_background_opacity then
                overrides.window_background_opacity = 0.86
            else
                overrides.window_background_opacity = nil
            end
            window:set_config_overrides(overrides)
        end),
    },
    {
        key = 'b',
        mods = 'CMD',
        action = wezterm.action_callback(function(window, _)
            local overrides = window:get_config_overrides() or {}
            if not overrides.my_is_dark_bg then -- setting dark background
                overrides.my_old_bg = config.colors.background
                if not overrides.colors then
                    overrides.colors = { background = '#0e0f17' }
                elseif overrides.colors then
                    overrides.my_old_bg = overrides.colors.background
                    overrides.colors.background = '#0e0f17'
                end
                overrides.my_is_dark_bg = true
            else -- unsetting dark background
                overrides.colors.background = overrides.my_old_bg
                overrides.my_is_dark_bg = false
            end
            window:set_config_overrides(overrides)
        end),
    },
    {
        key = 'l',
        mods = 'CMD',
        action = wezterm.action_callback(function(_, pane)
            pane:split({ direction = 'Right' })
        end),
    },
    {
        key = 'j',
        mods = 'CMD',
        action = wezterm.action_callback(function(_, pane)
            pane:split({ direction = 'Bottom' })
        end),
    },
    split_nav('h'),
    split_nav('j'),
    split_nav('k'),
    split_nav('l'),
}

wezterm.on('user-var-changed', function(window, _, name, value)
    wezterm.log_info('var', name, value)
    if name == 'COLORS_NAME' then
        local overrides = window:get_config_overrides() or {}
        if value == THEME then
            overrides.colors = nil
        else
            overrides.colors = require('themes.' .. value)
        end
        window:set_config_overrides(overrides)
    end
end)

wezterm.add_to_config_reload_watch_list("~/.dotfiles/.theme.txt")
wezterm.automatically_reload_config = true
return config
