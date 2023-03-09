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
        vim.cmd [[colorscheme no-clown-fiesta]]
    end,
    kanagawa = function()
        require('kanagawa').setup({
            compile = false, -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false, -- do not set background color
            dimInactive = false, -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = { -- add/modify theme and palette colors
                palette = {},
            },
            -- overrides = function(colors) -- add/modify highlights
            --     return {}
            -- end,
            theme = "wave", -- Load "wave" theme when 'background' option is not set
            background = { -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus"
            },
        })

        -- setup must be called before loading
        vim.cmd("colorscheme kanagawa")
    end
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
