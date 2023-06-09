local M = {}
local get_color = require('utils').get_color
local themes_list = { "noclownfiesta", "kanagawa", "kanagawa_muted", "gruvbox", "marsbox", }

vim.g.tjtheme = os.getenv("COLORS_NAME")
local valid_color = false
for _, v in ipairs(themes_list) do
    if v == vim.g.tjtheme then
        valid_color = true
    end
end
if not valid_color then vim.g.tjtheme = "kanagawa" end
-- vim.g.THEME = vim.env.COLORS_NAME

local colors_table = {
    noclownfiesta = function()
        require("no-clown-fiesta").setup {
            transparent = true,
        }
        vim.cmd [[colorscheme no-clown-fiesta]]
    end,
    kanagawa = function()
        require('kanagawa').setup({
            compile = false,  -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,   -- do not set background color
            dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = {             -- add/modify theme and palette colors
                palette = {},
            },
            -- overrides = function(colors) -- add/modify highlights
            --     return {}
            -- end,
            theme = "wave",    -- Load "wave" theme when 'background' option is not set
            background = {
                               -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus"
            },
        })

        -- setup must be called before loading
        vim.cmd("colorscheme kanagawa")
    end,
    kanagawa_muted = function()
        require('kanagawa').setup({
            compile = false,  -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,   -- do not set background color
            dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = {             -- add/modify theme and palette colors
                palette = {},
            },
            -- overrides = function(colors) -- add/modify highlights
            --     return {}
            -- end,
            theme = "dragon",    -- Load "wave" theme when 'background' option is not set
            background = {
                                 -- map the value of 'background' option to a theme
                dark = "dragon", -- try "dragon" !
                light = "lotus"
            },
        })

        -- setup must be called before loading
        vim.cmd("colorscheme kanagawa")
    end,

    gruvbox = function()
        vim.g.gruvbox_material_background = 'medium'
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_foreground = 'material'

        vim.cmd [[colorscheme gruvbox-material]]
    end,

    marsbox = function()
        require('marsbox').setup {}
        vim.cmd("colorscheme marsbox")
    end
}

local hl_table = {
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
            { 'WinSeparator',           { fg = '#54546D' } }
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
    },
    kanagawa_muted = {
        setup = {
            { 'Operator',               { fg = '#737c73', } },
            { '@punctuation.bracket',   { fg = '#737c73', } },
            { '@punctuation.delimiter', { fg = '#737c73', } },
            { 'WinSeparator',           { fg = '#60656f' } }
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#949fb5' } },
            { 'AlphaFooter1', { fg = '#c4746e' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#c4b28a', } },
            { 'NvimTreeFolderName',       { fg = '#949fb5', } },
            { 'NvimTreeOpenedFolderName', { fg = '#8a9a7b', } },
            { 'NvimTreeNormal',           { fg = '#c4b28a', } },
            { 'NvimTreeExecFile',         { fg = '#c5c9c5', } },
            { 'NvimTreeGitNew',           { fg = '#b6927b', } },
            { 'NvimTreeGitDirty',         { fg = '#c4746e', } },
            { 'NvimTreeOpenedFile',       { fg = '#a292a3', } },
            -- { 'NvimTreeIndentMarker',     { fg = '#e1e1e1', } },
        },
    },
    gruvbox = {
        setup = {
            { 'Operator',               { fg = '#81878f', } },
            { '@punctuation.bracket',   { fg = '#81878f', } },
            { '@punctuation.delimiter', { fg = '#81878f', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#89b4a2' } },
            { 'AlphaFooter1', { fg = '#ea6962' } },
        },
        nvim_tree = {
            { 'NvimTreeFolderIcon',       { fg = '#d8a657', } },
            { 'NvimTreeFolderName',       { fg = '#7daea3', } },
            { 'NvimTreeOpenedFolderName', { fg = '#89b482', } },
            { 'NvimTreeNormal',           { fg = '#928374', } },
            { 'NvimTreeNormalNC',         { fg = '#928374', } },
            { 'NvimTreeEndOfBuffer',      { fg = '#928374', } },
            { 'NvimTreeExecFile',         { fg = '#d4be98', } },
            { 'NvimTreeGitNew',           { fg = '#d8a657', } },
            { 'NvimTreeGitDirty',         { fg = '#ea6962', } },
            { 'NvimTreeOpenedFile',       { fg = '#d3869b', } },
            { 'NvimTreeRootFolder',       { fg = '#d4be98', } },
        },
    },
    marsbox = {
        setup = {
            { 'Operator',               { fg = '#928374', } },
            { '@punctuation.bracket',   { fg = '#928374', } },
            { '@punctuation.delimiter', { fg = '#928374', } },
        },
        alpha = {
            { 'AlphaHeader',  { fg = '#8ec07c' } },
            { 'AlphaFooter1', { fg = '#fb4934' } },
        },
        nvim_tree = {
            { 'NvimTreeNormal', { fg = '#928374' } }
        }
    },
}

local clear_hl_bg_table = {
    'Normal',
    'NormalNC',
    'EndOfBuffer',
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
    -- 'NormalFloat',
    -- 'FloatBorder',
    -- 'FloatBoder',
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

function M.clear_hl_bg(hl)
    local fgcolor = require('utils').get_color(hl, 'fg#')
    if hl == "Normal" then
        vim.api.nvim_set_hl(0, hl, { fg = fgcolor, bg = '' })
        return
    end
    if fgcolor ~= "" then
        vim.api.nvim_set_hl(0, hl, { fg = fgcolor, bg = require('utils').get_color('Normal', 'bg#') })
    else
        vim.api.nvim_set_hl(0, hl, { fg = require('utils').get_color('Normal', 'fg#'), bg = require('utils').get_color('Normal', 'bg#') })
    end
end

function M.clear_hl(hl)
    vim.api.nvim_set_hl(0, hl, {})
end
-- u/lkhphuc
function M.mod_hl(hl_name, opts)
    local is_ok, hl_def = pcall(vim.api.nvim_get_hl, hl_name, true)
    if is_ok then
        for k, v in pairs(opts) do hl_def[k] = v end
        vim.api.nvim_set_hl(0, hl_name, hl_def)
    end
end

local function setup_hls()
    vim.g.normalbg = get_color('Normal', 'bg#')
    vim.g.normalfg = get_color('Normal', 'fg#')
    for _, v in ipairs(clear_hl_bg_table) do
        M.clear_hl_bg(v)
    end
    for _, v in ipairs(clear_hl_table) do
        M.clear_hl(v)
    end
    for _, v in ipairs(mod_hl_table) do
        M.mod_hl(v[1], v[2])
    end
end

local function hl_category_setup(category, theme)
    local colorscheme = hl_table[theme]
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

function M.setup(category)
    if not category then
        colors_table[vim.g.tjtheme]()
        hl_category_setup('setup', vim.g.tjtheme)
        return
    end
    hl_category_setup(category, vim.g.tjtheme)
end

function M.reload()
    M.setup()
    M.setup('alpha')
    M.setup('nvim_tree')
    require('config.bufferline')
    require('config.lualine')
end

return M
