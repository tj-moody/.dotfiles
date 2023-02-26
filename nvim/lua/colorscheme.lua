local M = {}

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
