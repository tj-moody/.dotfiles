local wezterm = require("wezterm") or {}
local config = {}

config.font = wezterm.font("FiraCode NFM", {
    weight = "Medium",
})
config.font_size = 11
config.cell_width = 1
config.line_height = 1
config.bold_brightens_ansi_colors = "No"
config.freetype_render_target = "HorizontalLcd"
config.freetype_load_flags = "NO_HINTING"

-- TURN OFF LIGATURES
-- config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}

-- TODO: Update pending
-- https://github.com/wez/wezterm/issues/4610
-- config.underline_thickness = 3
config.underline_position = -4

local function read_theme()
    local home = os.getenv("HOME")
    package.path = package.path .. ";" .. home .. "/.dotfiles/?.lua"
    local ok, schema = pcall(require, "theme_schema")
    if not ok then
        return "marsbox"
    end
    return schema.name
end

config.colors = require("themes." .. read_theme()).palette

config.window_background_opacity = 1
config.macos_window_background_blur = 39

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.colors.tab_bar = {
    active_tab = {
        bg_color = config.colors.background,
        fg_color = config.colors.foreground,
    },
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
    return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
    Left = "h",
    h = "Left",
    Down = "j",
    j = "Down",
    Up = "k",
    k = "Up",
    Right = "l",
    l = "Right",
}

local function split_nav(key)
    return {
        key = key,
        mods = "CTRL",
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({ SendKey = { key = key, mods = "CTRL" } }, pane)
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
        key = "u",
        mods = "CMD",
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
        key = "l",
        mods = "CMD",
        action = wezterm.action_callback(function(_, pane)
            pane:split({ direction = "Right" })
        end),
    },
    {
        key = "j",
        mods = "CMD",
        action = wezterm.action_callback(function(_, pane)
            pane:split({ direction = "Bottom" })
        end),
    },
    -- split_nav("h"),
    -- split_nav("j"),
    -- split_nav("k"),
    -- split_nav("l"),
}

wezterm.add_to_config_reload_watch_list("~/.dotfiles/theme_schema.lua")
wezterm.automatically_reload_config = true
return config
