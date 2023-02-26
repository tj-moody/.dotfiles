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

function M.setup(category)
    if not category then
        colors_table[M.THEME]()
        require('hlgroups').hl_category_setup('setup', M.THEME)
        return
    end
    require('hlgroups').hl_category_setup(category, M.THEME)
end

return M
