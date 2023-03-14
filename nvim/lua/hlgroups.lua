local M = {}


M.hl_table = {
    noclownfiesta = {
        setup = {
            { 'CursorLineNr',           { fg = '#afafaf' } },
            { 'DiagnosticInfo',         { fg = '#a2b5c1', } },
            { '@operator',              { fg = '#727272', } },
            { '@punctuation.bracket',   { fg = '#727272', } }, -- still debating gray parens
            { '@punctuation.delimiter', { fg = '#727272', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#bad7ff' } },
            { 'AlphaFooter1', { fg = '#b46958' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#ffa557', } },
            { 'NvimTreeFolderName',       { fg = '#7e97ab', } },
            { 'NvimTreeOpenedFolderName', { fg = '#88afa2', } },
            { 'NvimTreeExecFile',         { fg = '#e1e1e1', } },
            { 'NvimTreeGitNew',           { fg = '#ffa557', } },
            { 'NvimTreeGitDirty',         { fg = '#b46958', } },
            { 'NvimTreeOpenedFile',       { fg = '#bad7ff', } },
            { 'NvimTreeIndentMarker',     { fg = '#e1e1e1', } },
        },
    },
    kanagawa = {
        setup = {
            { 'Operator',               { fg = '#727169', } },
            { '@punctuation.bracket',   { fg = '#727169', } },
            { '@punctuation.delimiter', { fg = '#727169', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#7fb4ca' } },
            { 'AlphaFooter1', { fg = '#ff5d62' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#DCA561', } },
            { 'NvimTreeFolderName',       { fg = '#658594', } },
            { 'NvimTreeOpenedFolderName', { fg = '#7aa89f', } },
            { 'NvimTreeNormal',           { fg = '#c8c093', } },
            { 'NvimTreeExecFile',         { fg = '#dcd7ba', } },
            { 'NvimTreeGitNew',           { fg = '#ffa066', } },
            { 'NvimTreeGitDirty',         { fg = '#ff5d62', } },
            { 'NvimTreeOpenedFile',       { fg = '#957fb8', } },
            -- { 'NvimTreeIndentMarker',     { fg = '#e1e1e1', } },
        },
    }
}

local clear_hl_bg_table = {
    'Normal',
    'NormalNC',
    'StatusColumn',
    'SignColumn',
    'FoldColumn',
    'ColorColumn',
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
    'Title',
    'NonText',
    'FloatShadow',
    'FloatShadowThrough',
    'LineNr',
    'LineNrAbove',
    'LineNrBelow',
    'CursorLineNr',
    'TreesitterContext',
    'GitSignsAdd',
    -- 'TermCursor',
    -- 'TermCursorNC',

    'GitSignsChange',
    'DiagnosticSignError',
    'DiagnosticSignWarn',
    'DiagnosticSignInfo',
    'DiagnosticSignHint',
}
local clear_hl_table = {
    'CursorLine',
    'NonText',
}
local mod_hl_table = {
    { 'Comment',   { italic = true, } },
    { '@comment',  { italic = true, } },
    { 'Statement', { bold = false, } },
    { 'Keyword',   { bold = false, italic = true, } },
    { '@keyword',  { bold = false, italic = true, } },
}

local function clear_hl_bg(hl)
    local fgcolor = require('utils').get_color(hl, 'fg#')
    if fgcolor ~= "" then
        vim.api.nvim_set_hl(0, hl, { fg = fgcolor, bg = '' })
    else
        vim.api.nvim_set_hl(0, hl, { fg = require('utils').get_color('Normal', 'fg#'), bg = '' })
    end
end
local function clear_hl(hl)
    vim.api.nvim_set_hl(0, hl, {})
end
-- u/lkhphuc
local function mod_hl(hl_name, opts)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
    if is_ok then
        for k, v in pairs(opts) do hl_def[k] = v end
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
    end
end

return M
