local colors_table = {
    noclownfiesta = {
        normal = '#90a959',
        replace = '#b46958',
        visual = '#ffa557',
        insert = '#7e97ab',
    },
    kanagawa = {
        normal = '#98bb6c',
        replace = '#ff5d62',
        visual = '#ffa066',
        insert = '#7fb4ca',
    },
    kanagawa_muted = {
        normal = '#8a9a7b',
        replace = '#c4746e',
        visual = '#b6927b',
        insert = '#949fb5',
    },
    gruvbox = {
        normal = '#a9b66f',
        replace = '#ea6962',
        visual = '#e7a84e',
        insert = '#7daea3',
    },
}

local THEME = vim.g.tjtheme
local colors = colors_table.noclownfiesta
if THEME and colors_table[THEME] then
    colors = colors_table[THEME]
end

local theme = {
    normal = {
        a = { fg = colors.normal, bg = colors.bg },
        b = { fg = colors.bg, bg = colors.bg },
        c = { fg = colors.bg, bg = colors.bg },
        z = { fg = colors.bg, bg = colors.bg },
    },
    insert = { a = { fg = colors.insert, bg = colors.bg } },
    visual = { a = { fg = colors.visual, bg = colors.bg } },
    replace = { a = { fg = colors.replace, bg = colors.bg } },
}

local lualine_config = {
    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {
                "NvimTree",
                "toggleterm",
                "TelescopePicker",
                "alpha",
            },
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {
            {
                function()
                    return ''
                end,
                padding = { left = 1, right = 2 },
            }
        },
        lualine_b = {
            -- {
            --     'branch',
            --     icon = '',
            --     padding = 2,
            -- },
            -- {
            --     'diff',
            --     icon = '',
            --     diff_color = {
            --         added = { fg = colors.normal },
            --         modified = { fg = colors.visual },
            --         removed = { fg = colors.replace },
            --     },
            --     symbols = { added = '', modified = '', removed = '' },
            -- },
            {
                'branch',
                icon = '',
                padding = { left = 2, right = 1, }
            },
            {
                'diff',
                diff_color = {
                    added = { fg = colors.normal },
                    modified = { fg = colors.visual },
                    removed = { fg = colors.replace },
                },
                symbols = { added = '', modified = '', removed = '' },
                padding = 1,
            },
        },
        lualine_c = {
            {
                function()
                    return '%='
                end,
            },
            {
                'filetype',
                icon_only = true,
            },
            {
                'filename',
                symbols = {
                    modified = '',
                    readonly = '',
                    unnamed = '[No Name]',
                    newfile = '',
                },
            },
        },
        lualine_x = {},
        lualine_y = {
            {
                'diagnostics',
                symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                -- symbols = {error = '', warn = '', info = '', hint = ''},
            },
            {
                function()
                    return ''
                end,
                color = function()
                    if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
                        return { fg = colors.normal }
                    end
                    return {}
                end,
            },
            {
                function()
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                icon = '',
            },
        },
        lualine_z = {
            {
                function()
                    return os.date('%H:%M')
                end,
                color = { fg = colors.normal },
                padding = { left = 2, right = 1 },
            },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

require('lualine').setup(lualine_config)
