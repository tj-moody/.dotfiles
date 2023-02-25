local M = {}

local function clear_hl_bg(hl)
    local fgcolor = require('utils').getcolor(hl, 'fg#')
    if hl ~= 'Normal' then
        vim.api.nvim_set_hl(0, hl, {fg = require('utils').getcolor('Normal', 'fg#'), bg = ''})
    else
        vim.api.nvim_set_hl(0, hl, {fg = '#ffffff', bg = ''})
    end
end

M.THEME = os.getenv("COLORS_NAME")
if not M.THEME then
    M.THEME = "noclownfiesta"
end

local colors_table = {
    noclownfiesta = function()
        require("no-clown-fiesta").setup {
            transparent = false,
        }
        vim.cmd[[colorscheme no-clown-fiesta]]
    end,
}

function M.setup()
    colors_table[M.THEME]()
    -- vim.api.nvim_set_hl(0, 'Normal', {fg = require('utils').getcolor('Normal', 'fg#'), bg = ''})
    clear_hl_bg('Normal')
    clear_hl_bg('NormalNC')
    clear_hl_bg('StatusColumn')
    clear_hl_bg('SignColumn')
    clear_hl_bg('FoldColumn')
    clear_hl_bg('StatusLine')
    clear_hl_bg('StatusLineNC')
    clear_hl_bg('StatusLineTerm')
    clear_hl_bg('StatusLineTermNC')
    clear_hl_bg('NvimTreeStatusLine')
    clear_hl_bg('MsgArea')
    clear_hl_bg('ModeMsg')
    clear_hl_bg('MsgSeparator')
end

function M.alpha()
    require('hlgroups').hltable[M.THEME].alpha()
end

return M
