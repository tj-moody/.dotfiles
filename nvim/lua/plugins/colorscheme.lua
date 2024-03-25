---@class Colorscheme
---@field themes_list Array[string]
---@field clear_hl_bg function
---@field mod_hl function
---@field setup function
---@field safe_reload function
---@field reload function
local M = {}

-- u/Pocco81
local fn = vim.fn
---Get the color of an attribute of a highlight group
---@param group string name of hl
---@param attr 'bg#' | 'fg#'
---@return string color color of attr '#XXXXXX'
function M.get_color(group, attr)
    ---@diagnostic disable-next-line return-type-mismatch
    return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

M.themes_list = {
    'noclownfiesta',
    'kanagawa',
    'gruvbox',
    'tokyonight',
    'oxocarbon',
    'catppuccin',
    'everforest',
    'ayu',
    'midnightclub',
}

vim.g.tjtheme = os.getenv('COLORS_NAME')
local valid_color = false
for _, v in ipairs(M.themes_list) do
    if v == vim.g.tjtheme then
        valid_color = true
    end
end
if not valid_color and not vim.g.tjtheme then vim.g.tjtheme = 'kanagawa' end
-- vim.g.THEME = vim.env.COLORS_NAME

local colors_table = {
    noclownfiesta = function() -- {{{
        vim.cmd.colorscheme('no-clown-fiesta')
    end,                       -- }}}
    kanagawa = function()      -- {{{
        vim.cmd.colorscheme('kanagawa')
    end,                       -- }}}
    gruvbox = function()       -- {{{
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_background = 'soft'
        vim.g.gruvbox_material_foreground = 'original'
        vim.cmd.colorscheme('gruvbox-material')
    end,                      -- }}}
    tokyonight = function()   -- {{{
        vim.cmd.colorscheme('tokyonight')
    end,                      -- }}}
    oxocarbon = function()    -- {{{
        vim.cmd.colorscheme('carbonfox')
    end,                      -- }}}
    catppuccin = function()   -- {{{
        vim.cmd.colorscheme('catppuccin')
    end,                      -- }}}
    everforest = function()   -- {{{
        vim.cmd('colorscheme everforest')
    end,                      -- }}}
    ayu = function()          -- {{{
        vim.cmd.colorscheme('ayu')
    end,                      -- }}}
    midnightclub = function() --{{{
        vim.cmd.colorscheme('midnight-club')
    end,                      -- }}}
}

local hl_table = {
    noclownfiesta = { -- {{{
        setup = {
            { 'CursorLineNr',           { fg = '#afafaf' } },
            { 'DiagnosticInfo',         { fg = '#a2b5c1', } },
            { '@operator',              { fg = '#727272', } },
            { '@punctuation.bracket',   { fg = '#727272', } },
            { '@punctuation.delimiter', { fg = '#727272', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#bad7ff' } },
            { 'AlphaFooter1', { fg = '#b46958' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#ffa557', } },
            { 'NvimTreeFolderName',       { fg = '#7e97ab', } },
            { 'NvimTreeOpenedFolderName', { fg = '#88afa2', bold = true, } },
            { 'NvimTreeExecFile',         { fg = '#e1e1e1', } },
            { 'NvimTreeGitNew',           { fg = '#ffa557', } },
            { 'NvimTreeGitDirty',         { fg = '#b46958', } },
            { 'NvimTreeOpenedFile',       { fg = '#bad7ff', } },
            { 'NvimTreeIndentMarker',     { fg = '#e1e1e1', } },
        },
    },           -- }}}
    kanagawa = { -- {{{
        setup = {
            { 'Operator',               { fg = '#727169', } },
            { '@punctuation.bracket',   { fg = '#727169', } },
            { '@punctuation.delimiter', { fg = '#727169', } },
            { 'WinSeparator',           { fg = '#54546D', } },
            { 'LspInlayHint',           { fg = '#938aa9', bold = true, } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#7fb4ca' } },
            { 'AlphaFooter1', { fg = '#ff5d62' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#DCA561', } },
            { 'NvimTreeFolderName',       { fg = '#658594', } },
            { 'NvimTreeOpenedFolderName', { fg = '#7aa89f', bold = true, } },
            { 'NvimTreeNormal',           { fg = '#c8c093', } },
            { 'NvimTreeExecFile',         { fg = '#dcd7ba', } },
            { 'NvimTreeGitNew',           { fg = '#ffa066', } },
            { 'NvimTreeGitDirty',         { fg = '#ff5d62', } },
            { 'NvimTreeOpenedFile',       { fg = '#957fb8', bold = true, } },
            -- { 'NvimTreeIndentMarker',     { fg = '#e1e1e1', } },
        },
    },          -- }}}
    gruvbox = { -- {{{
        setup = {
            { 'Operator',                   { fg = '#928374', } },
            { '@operator',                  { fg = '#928374', } },
            { '@punctuation.bracket',       { fg = '#928374', } },
            { '@punctuation.delimiter',     { fg = '#928374', } },
            { 'NormalFloat',                { bg = '#060911', } },
            { 'FloatBorder',                { bg = '#060911', } },
            { 'DiagnosticVirtualTextInfo',  { fg = '#83a598', } },
            { 'DiagnosticVirtualTextHint',  { fg = '#b8bb26', } },
            { 'DiagnosticVirtualTextWarn',  { fg = '#fabd2f', } },
            { 'DiagnosticVirtualTextError', { fg = '#fb4934', } },
            { 'InfoText',                   { fg = '#83a598', } },
            { 'HintText',                   { fg = '#b8bb26', } },
            { 'WarningText',                { fg = '#fabd2f', } },
            { 'ErrorText',                  { fg = '#fb4934', } },
            { 'LspInlayHint',               { fg = '#83a598', bold = true, } },
            { 'FloatTitle',                 { bg = '#060911', fg = '#83a598', } },
            { 'MatchParen',                 { fg = '#a454ff', bold = true, } },
            { 'Search',                     { fg = '#b8bb26', bold = true, } },
            { 'IncSearch',                  { fg = '#fb4934', bold = true, } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#89b4a2' } },
            { 'AlphaFooter1', { fg = '#fb4934' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#fabd2f', } },
            { 'NvimTreeFolderName',       { fg = '#83a598', } },
            { 'NvimTreeOpenedFolderName', { fg = '#8ec07c', bold = true, } },
            { 'NvimTreeNormal',           { fg = '#928374', } },
            { 'NvimTreeNormalNC',         { fg = '#928374', } },
            { 'NvimTreeEndOfBuffer',      { fg = '#928374', } },
            { 'NvimTreeExecFile',         { fg = '#d4be98', } },
            { 'NvimTreeGitNew',           { fg = '#fabd2f', } },
            { 'NvimTreeGitDirty',         { fg = '#fb4934', } },
            { 'NvimTreeOpenedFile',       { fg = '#d3869b', bold = true, } },
            { 'NvimTreeRootFolder',       { fg = '#d4be98', bold = true, } },
        },
    },             -- }}}
    tokyonight = { -- {{{
        setup = {
            { 'DiffAdd',                { bg = '#283B4D', } },
            { 'DiffChange',             { bg = '#28304d', } },
            { 'DiffText',               { bg = '#36426b', } },
            { 'DiffDelete',             { bg = '#37222c', fg = '#37222c', } },
            { 'WinSeparator',           { fg = '#3b4261', } },
            { 'Operator',               { fg = '#3b4261', } },
            { '@operator',              { fg = '#3b4261', } },
            { '@punctuation.bracket',   { fg = '#3b4261', } },
            { '@punctuation.delimiter', { fg = '#3b4261', } },
            { 'TelescopeBorder',        { fg = '#3b4261', } },
            { 'LspInlayHint',           { fg = '#2ac3de', } },
            { 'NormalFloat',            { bg = '#060911', } },
            { 'Normal',                 { bg = '#0e0f17', } },
            { 'FloatBorder',            { bg = '#060911', fg = '#29a4bd' } },
            { 'FloatTitle',             { bg = '#060911', fg = '#29a4bd', } },
            -- { 'TreesitterContext',      {} },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#2ac3de' } },
            { 'AlphaFooter1', { fg = '#f7768e' } },
        },
        nvim_tree = {
            { 'NvimTreeWinSeparator',     { fg = '#3b4261' } },
            { 'NvimTreeFolderIcon',       { fg = '#e0af68', } },
            { 'NvimTreeFolderName',       { fg = '#73daca', } },
            { 'NvimTreeOpenedFolderName', { fg = '#2ac3de', bold = true, } },
            { 'NvimTreeNormal',           { fg = '#565f89', } },
            { 'NvimTreeNormalNC',         { fg = '#565f89', } },
            { 'NvimTreeEndOfBuffer',      { fg = '#565f89', } },
            { 'NvimTreeExecFile',         { fg = '#c0caf5', } },
            { 'NvimTreeGitNew',           { fg = '#e0af68', } },
            { 'NvimTreeGitDirty',         { fg = '#f7768e', } },
            { 'NvimTreeOpenedFile',       { fg = '#bb9af7', bold = true, } },
            { 'NvimTreeRootFolder',       { fg = '#c0caf5', } },
        },
    },            -- }}}
    oxocarbon = { -- {{{
        setup = {
            { 'WinSeparator',           { fg = '#6e6f70' } },
            { 'Operator',               { fg = '#6e6f70', } },
            { '@operator',              { fg = '#6e6f70', } },
            { '@punctuation.bracket',   { fg = '#6e6f70', } },
            { '@punctuation.delimiter', { fg = '#6e6f70', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#78a9ff' } },
            { 'AlphaFooter1', { fg = '#ee5396' } },
        },
        nvim_tree = {
            { 'NvimTreeWinSeparator',     { fg = '#6e6f70' } },
            { 'NvimTreeFolderIcon',       { fg = '#e0af68', } },
            { 'NvimTreeFolderName',       { fg = '#5ae0df', } },
            { 'NvimTreeOpenedFolderName', { fg = '#78a9ff', } },
            { 'NvimTreeNormal',           { fg = '#6e6f70', } },
            { 'NvimTreeNormalNC',         { fg = '#6e6f70', } },
            { 'NvimTreeEndOfBuffer',      { fg = '#6e6f70', } },
            { 'NvimTreeExecFile',         { fg = '#f2f4f8', } },
            { 'NvimTreeGitNew',           { fg = '#e0af68', } },
            { 'NvimTreeGitDirty',         { fg = '#ee5396', } },
            { 'NvimTreeOpenedFile',       { fg = '#c8a5ff', } },
            { 'NvimTreeRootFolder',       { fg = '#f2f4f8', } },
        },
    },             -- }}}
    catppuccin = { -- {{{
        setup = {
            { 'WinSeparator',           { fg = '#6c7086' } },
            { 'Operator',               { fg = '#6c7086', } },
            { '@operator',              { fg = '#6c7086', } },
            { '@punctuation.bracket',   { fg = '#6c7086', } },
            { '@punctuation.delimiter', { fg = '#6c7086', } },
            { 'TelescopeBorder',        { fg = '#6c7086', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#89b4fa' } },
            { 'AlphaFooter1', { fg = '#f38ba8' } },
        },
        nvim_tree = {
            { 'NvimTreeWinSeparator',     { fg = '#6c7086' } },
            { 'NvimTreeFolderIcon',       { fg = '#fab387', } },
            { 'NvimTreeFolderName',       { fg = '#94e2d5', } },
            { 'NvimTreeOpenedFolderName', { fg = '#89b4fa', } },
            { 'NvimTreeNormal',           { fg = '#6c7086', } },

            { 'NvimTreeEndOfBuffer',      { fg = '#6c7086', } },
            { 'NvimTreeExecFile',         { fg = '#cdd6f4', } },
            { 'NvimTreeGitNew',           { fg = '#f9e2af', } },
            { 'NvimTreeGitDirty',         { fg = '#f38ba8', } },
            { 'NvimTreeOpenedFile',       { fg = '#cba6f7', } },
            { 'NvimTreeRootFolder',       { fg = '#cdd6f4', } },
        },
    },             -- }}}
    everforest = { -- {{{
        setup = {
            { 'StatusLineNC',           { fg = '#859288' } },
            { 'Operator',               { fg = '#859288', } },
            { '@operator',              { fg = '#859288', } },
            { '@punctuation.bracket',   { fg = '#859288', } },
            { '@punctuation.delimiter', { fg = '#859288', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#7fbbb3' } },
            { 'AlphaFooter1', { fg = '#e67e80' } },
        },
        nvim_tree = {
            { 'NvimTreeWinSeparator',     { fg = '#555f66' } },
            { 'NvimTreeFolderIcon',       { fg = '#dbbc7f', } },
            { 'NvimTreeFolderName',       { fg = '#8ec092', } },
            { 'NvimTreeOpenedFolderName', { fg = '#7fbbb3', } },
            { 'NvimTreeNormal',           { fg = '#859289', } },
            { 'NvimTreeNormalNC',         { fg = '#859289', } },
            { 'NvimTreeEndOfBuffer',      { fg = '#859289', } },
            { 'NvimTreeExecFile',         { fg = '#d3c6aa', } },
            { 'NvimTreeGitNew',           { fg = '#dbbc7f', } },
            { 'NvimTreeGitDirty',         { fg = '#e67e80', } },
            { 'NvimTreeOpenedFile',       { fg = '#d699b6', } },
            { 'NvimTreeRootFolder',       { fg = '#d3c6aa', } },
        },
    },      -- }}}
    ayu = { -- {{{
        setup = {
            { 'Operator',               { fg = '#626a73', } },
            { '@punctuation.bracket',   { fg = '#626a73', } },
            { '@punctuation.delimiter', { fg = '#626a73', } },
            { 'WinSeparator',           { fg = '#626a73', } },
            { 'GitSignsAdd',            { fg = '#c2d94c', } },
            { 'GitSignsAddLine',        { fg = '#c2d94c', } },
            { 'GitSignsAddNr',          { fg = '#c2d94c', } },
            { 'GitSignsDelete',         { fg = '#d96c75', } },
            { 'GitSignsDeleteNr',       { fg = '#d96c75', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#c2d94c' } },
            { 'AlphaFooter1', { fg = '#ff8f40' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#e6b450', } },
            { 'NvimTreeNormal',           { fg = '#626a73', } },
            { 'NvimTreeNormalNC',         { fg = '#626a73', } },
            { 'NvimTreeGitNew',           { fg = '#e6b450', } },
            { 'NvimTreeGitDirty',         { fg = '#f07178', } },
            { 'NvimTreeFolderName',       { fg = '#39bae6', } },
            { 'NvimTreeOpenedFolderName', { fg = '#a7e3cc', bold = true, } },
            { 'NvimTreeOpenedFile',       { fg = '#cb9ff8', bold = true, } },
            { 'NvimTreeExecFile',         { fg = '#b3b1ad', } },
            { 'NvimTreeRootFolder',       { fg = '#ff8f40', bold = true, } },
        },
    },               -- }}}
    midnightclub = { -- {{{
        setup = {
            { 'MatchParen',       { fg = '#00f5d4', } },
            { 'CursorLineNr',     { fg = '#ffae57', } },
            { 'StatusLineNC',     { fg = '#2d3541', } },
            { 'GitSignsAdd',      { fg = '#7cb375', } },
            { 'GitSignsAddLine',  { fg = '#7cb375', } },
            { 'GitSignsAddNr',    { fg = '#7cb375', } },
            { 'GitSignsDelete',   { fg = '#fc735d', } },
            { 'GitSignsDeleteNr', { fg = '#fc735d', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#88d4ab' } },
            { 'AlphaFooter1', { fg = '#ffae57' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#ffae57', } },
            { 'NvimTreeNormal',           { fg = '#565656', } },
            { 'NvimTreeNormalNC',         { fg = '#565656', } },
            { 'NvimTreeGitNew',           { fg = '#ffae57', } },
            { 'NvimTreeGitDirty',         { fg = '#fc735d', } },
            { 'NvimTreeFolderName',       { fg = '#88d4ab', } },
            { 'NvimTreeOpenedFolderName', { fg = '#00f5d4', bold = true, } },
            { 'NvimTreeOpenedFile',       { fg = '#c9cba3', bold = true, } },
            { 'NvimTreeExecFile',         { fg = '#cfdbd5', } },
            { 'NvimTreeRootFolder',       { fg = '#ffae57', bold = true, } },
        },
    }, -- }}}
}

local clear_hl_bg_table = { -- {{{
    'Normal',
    'NormalNC',
    'NormalSB',
    'SignColumnSB',
    'EndOfBuffer',
    'StatusColumn',
    'SignColumn',
    'FoldColumn',
    -- 'ColorColumn',
    'StatusLine',
    'StatusLineNC',
    'StatusLineTerm',
    'StatusLineTermNC',
    'NvimTreeStatusLine',
    'MsgArea',
    'ModeMsg',
    'MsgSeparator',
    -- 'NormalFloat',
    -- 'FloatBorder',
    -- 'FloatBoder',
    'VertSplit',
    'WinSeparator',

    'TelescopeNormal',
    'TelescopeBorder',
    'TelescopeSelection',

    'NvimTreeNormal',
    'NvimTreeNormalNC',
    -- 'NvimTreeNormalFloat',
    'ErrorMsg',
    'WarningMsg',
    'Title',
    'NonText',
    -- 'FloatShadow',
    -- 'FloatShadowThrough',
    'LineNr',
    'LineNrAbove',
    'LineNrBelow',
    'CursorLineNr',
    'TreesitterContext',
    'TreesitterContextLineNumber',
    'GitSignsAdd',
    'GitSignsChange',
    'GitSignsDelete',
    'MatchParen',

    'DiagnosticSignError',
    'DiagnosticSignWarn',
    'DiagnosticSignInfo',
    'DiagnosticSignHint',

    'Folded',

    'TabLineFill',
}                        -- }}}
local clear_hl_table = { -- {{{
    'CursorLine',
    'NonText',
}                      -- }}}
local mod_hl_table = { -- {{{
    { 'Comment',      { italic = true, } },
    { '@comment',     { italic = true, } },
    { 'Statement',    { bold = false, } },
    { 'Keyword',      { bold = false, italic = true, } },
    { '@keyword',     { bold = false, italic = true, } },
    { 'Folded',       { bold = true, } },
    { 'TermCursor',   { link = 'Cursor' } },
    { 'TermCursorNC', { link = 'Normal' } },
    { 'LspInlayHint', { italic = true, bg = "", } },
}                      -- }}}
local set_hl_table = { -- {{{
    { 'DiagnosticUnderlineError', { undercurl = true, sp = M.get_color('DiagnosticError', 'fg#'), } },
    { 'DiagnosticUnderlineWarn',  { undercurl = true, sp = M.get_color('DiagnosticWarn', 'fg#'), } },
    { 'DiagnosticUnderlineHint',  { undercurl = true, sp = M.get_color('DiagnosticHint', 'fg#'), } },
    { 'DiagnosticUnderlineInfo',  { undercurl = true, sp = M.get_color('DiagnosticInfo', 'fg#'), } },
    { 'DiagnosticUnderlineOk',    { undercurl = true, sp = M.get_color('DiagnosticOk', 'fg#'), } },
} -- }}}

---Remove background from highlight group `hl`
---@param hl string
function M.clear_hl_bg(hl)
    local fgcolor = M.get_color(hl, 'fg#')
    if hl == 'Normal' then
        vim.api.nvim_set_hl(0, hl, { fg = fgcolor, bg = '' })
        return
    end
    if fgcolor ~= '' then
        vim.api.nvim_set_hl(0, hl, {
            fg = fgcolor,
            bg = M.get_color('Normal', 'bg#'),
        })
    else
        vim.api.nvim_set_hl(0, hl, {
            fg = M.get_color('Normal', 'fg#'),
            bg = M.get_color('Normal', 'bg#'),
        })
    end
end

---Applies `opts` to `hl` without modifying `hl` otherwise
---
---Example:
--- ```lua
---    mod_hl('Normal', { fg = '#XXXXXX', bold = true })
--- ```
---@param hl_name string
---@param opts table
---
---Credit: u/lkhphuc
function M.mod_hl(hl_name, opts)
    local is_ok, hl_def = pcall(
        vim.api.nvim_get_hl, 0, { name = hl_name, link = true }
    )
    if is_ok then
        for k, v in pairs(opts) do hl_def[k] = v end
        vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
end

---Applies general hl changes specified in `clear_hl_bg_table`,
---`clear_hl_table`, and `mod_hl_table`
local function setup_hls()
    vim.g.normalbg = M.get_color('Normal', 'bg#')
    vim.g.normalfg = M.get_color('Normal', 'fg#')
    for _, v in ipairs(clear_hl_bg_table) do
        M.clear_hl_bg(v)
    end
    for _, v in ipairs(clear_hl_table) do
        vim.api.nvim_set_hl(0, v, {})
    end
    for _, v in ipairs(mod_hl_table) do
        M.mod_hl(v[1], v[2])
    end
    for _, v in ipairs(set_hl_table) do
        vim.api.nvim_set_hl(0, v[1], v[2])
    end
end

---Load theme-specific highlights in `category` as specified by *hl_table*
---
---If parameter `category` is not supplied, will
---load highlights in "setup" field of "hl_table"
---
---Examples:
--- ```lua
---    setup('NvimTree')
---    setup()
--- ```
---@param category? string
function M.setup(category)
    if not category or category == 'setup' then
        category = 'setup'
        colors_table[vim.g.tjtheme]()
    end
    local colorscheme = hl_table[vim.g.tjtheme]
    if colorscheme[category] then
        for _, v in ipairs(colorscheme[category]) do
            if next(v[2]) ~= nil then
                vim.api.nvim_set_hl(0, v[1], v[2])
            end
        end
    end
end

---Reload all colorscheme customizations that do not require a plugin
---@return nil
function M.safe_reload()
    M.setup()
    setup_hls()
    M.setup('alpha')
    M.setup('nvim_tree')
end

---Reload all colorscheme customizations
function M.reload()
    M.safe_reload()
    safe_require('plugins.bufferline').setup()
    safe_require('plugins.lualine').setup()
end

M.spec = {
    {
        lazy = false,
        'sainnhe/gruvbox-material',
        config = M.setup
    },
    {
        'aktersnurra/no-clown-fiesta.nvim',
        event = 'VeryLazy',
    },
    {
        'rebelot/kanagawa.nvim',
        event = 'VeryLazy',
    },
    {
        'folke/tokyonight.nvim',
        event = 'VeryLazy',
    },
    {
        'EdenEast/nightfox.nvim',
        event = 'VeryLazy',
    },
    {
        'catppuccin/nvim',
        event = 'VeryLazy',
    },
    {
        'sainnhe/everforest',
        event = 'VeryLazy',
    },
    {
        'Shatur/neovim-ayu',
        event = 'VeryLazy',
    },
    {
        'nyngwang/midnight-club.nvim',
        event = 'VeryLazy',
    },
}

return M
