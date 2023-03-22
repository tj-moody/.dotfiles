local M = {}

vim.g.tjtheme = os.getenv("COLORS_NAME")
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
    end,
    kanagawa_muted = function()
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
        theme = "dragon", -- Load "wave" theme when 'background' option is not set
        background = { -- map the value of 'background' option to a theme
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
}

function M.setup(category)
    if not category then
        colors_table[vim.g.tjtheme]()
        require('hlgroups').hl_category_setup('setup', vim.g.tjtheme)
        return
    end
    require('hlgroups').hl_category_setup(category, vim.g.tjtheme)
end

function M.reload()
    M.setup()
    M.setup('alpha')
    M.setup('nvim_tree')
    require('config.bufferline')
    require('config.lualine')
end

return M
