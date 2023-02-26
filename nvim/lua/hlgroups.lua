local M = {}

M.hl_table = {
    noclownfiesta = {
        alpha = {
            { 'AlphaHeader', { fg = '#bad7ff'} },
            { 'AlphaFooter1', { fg = '#b46958'} },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon', { fg = '#ffa557', }},
            { 'NvimTreeFolderName', { fg = '#7e97ab', }},
            { 'NvimTreeOpenedFolderName', { fg = '#88afa2', }},
            { 'NvimTreeExecFile', { fg = '#e1e1e1', }},
            { 'NvimTreeGitNew', { fg = '#ffa557', }},
            { 'NvimTreeGitDirty', { fg = '#b46958', }},
            { 'NvimTreeOpenedFile', { fg = '#bad7ff', }},
        },
    },
}

local clear_hl_bg_table = {
    'Normal',
    'NormalNC',
    'StatusColumn',
    'SignColumn',
    'FoldColumn',
    'StatusLine',
    'StatusLineNC',
    'StatusLineTerm',
    'StatusLineTermNC',
    'NvimTreeStatusLine',
    'MsgArea',
    'ModeMsg',
    'MsgSeparator',
    'NormalFloat',
    'FloatBorder',
    'FloatBoder',
    'VertSplit',
    'WinSeparator',
    'TelescopeNormal',
    'TelescopeBorder',
    'TelescopeSelection',
    'NvimTreeNormal',
    'ErrorMsg',
    'WarningMsg',
}
local clear_hl_table = {
    'CursorLine'
}
local mod_hl_table = {
    { 'Comment', { italic = true, } },
    { '@comment', { italic = true, } },
}

local function clear_hl_bg(hl)
    local fgcolor = require('utils').get_color(hl, 'fg#')
    if fgcolor ~= "" then
        vim.api.nvim_set_hl(0, hl, {fg = fgcolor, bg = ''})
    else
        vim.api.nvim_set_hl(0, hl, {fg = require('utils').get_color('Normal', 'fg#'), bg = ''})
    end
end
local function clear_hl(hl)
    vim.api.nvim_set_hl(0, hl, {})
end
-- u/lkhphuc
local function mod_hl(hl_name, opts)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
    if is_ok then
        for k,v in pairs(opts) do hl_def[k] = v end
        vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
end

local function setup_hls()
    vim.g.normalbg = require('utils').get_color('Normal', 'bg#')
    vim.g.normalfg = require('utils').get_color('Normal', 'fg#')
    for _, v in ipairs(clear_hl_bg_table) do
        clear_hl_bg(v)
    end
    for _, v in ipairs(clear_hl_table) do
        clear_hl(v)
    end
    for _, v in ipairs(mod_hl_table) do
        mod_hl(v[1], v[2])
    end
end


function M.hl_category_setup(category, theme)
    local colorscheme = M.hl_table[theme]
    if colorscheme[category] then
        for _, v in ipairs(colorscheme[category]) do
            if next(v[2]) ~= nil then
                vim.api.nvim_set_hl(0, v[1], v[2])
            end
        end
    end
    if category == "setup" then
        setup_hls()
    elseif category == "toggleterm" then
        vim.api.nvim_set_hl(0, 'TermCursorNC', { fg = vim.g.normalbg, bg = vim.g.normalfg})
        vim.api.nvim_set_hl(0, 'TermCursor', { fg = vim.g.normalbg, bg = vim.g.normalfg})
    end
end

return M
