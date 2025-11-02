local M = {}

local pigeon_config = {
    os = "osx", -- windows, osx
    plugin_manager = "lazy", -- packer, paq, vim-plug
    callbacks = {
        killing_pigeon = nil,
        respawning_pigeon = nil,
    },
    datetime = {
        enabled = true,
        time = {
            enabled = true,
            format = "%H:%M",
            posttext = "hrs",
            icon = "󰃰 ",
        },
        day = {
            enabled = true,
            format = "%A",
            icon = "󰃶 ",
        },
        date = {
            enabled = true,
            format = "%m-%d",
            icon = "",
        },
    },
}

M.setup = function()
    local colors_table = { -- {{{
        noclownfiesta = {
            normal = "#90a959",
            replace = "#b46958",
            visual = "#ffa557",
            insert = "#7e97ab",
        },
        kanagawa = {
            normal = "#98bb6c",
            replace = "#ff5d62",
            insert = "#7fb4ca",
            visual = "#ffa066",
        },
        marsbox = {
            normal = "#b8bb26",
            replace = "#fb4934",
            visual = "#fe8019",
            insert = "#83a598",
        },
        tokyonight = {
            normal = "#9ece6a",
            replace = "#f7768e",
            visual = "#ff9e64",
            insert = "#7dcfff",
        },
        oxocarbon = {
            normal = "#25be6a",
            replace = "#ee5396",
            visual = "#ff91c1",
            insert = "#3ddbd9",
        },
        catppuccin = {
            normal = "#a6e3a1",
            replace = "#f38ba8",
            visual = "#fab387",
            insert = "#89b4fa",
        },
        everforest = {
            normal = "#abbf86",
            replace = "#d88382",
            visual = "#e69875",
            insert = "#7fbbb3",
        },
        ayu = {
            normal = "#c2d94c",
            replace = "#f07178",
            visual = "#ff8f40",
            insert = "#39bae6",
        },
        midnightclub = {
            normal = "#7cb375",
            replace = "#fc735d",
            visual = "#ffae57",
            insert = "#88d4ab",
        },
        gruvbox = {
            normal = "#b8bb26",
            replace = "#fb4934",
            visual = "#fe8019",
            insert = "#83a598",
        },
        synth = {
            normal = "#00ff99",
            replace = "#ff5171",
            visual = "#ff9900",
            insert = "#c375ff",
        },
    } -- }}}

    local THEME = vim.g.tjtheme
    local colors = colors_table.marbox
    if THEME and colors_table[THEME] then
        colors = colors_table[THEME]
    end
    local comment_fg = safe_require("plugins.colorscheme").get_color("Comment", "fg#")

    local theme = {
        normal = {
            a = { fg = colors.normal, bg = colors.bg },
            b = { fg = colors.bg, bg = colors.bg },
            c = { fg = colors.bg, bg = colors.bg },
            z = { fg = colors.bg, bg = colors.bg },
        },
        insert = { a = { fg = colors.insert, bg = colors.bg } },
        terminal = { a = { fg = colors.insert, bg = colors.bg } },
        visual = { a = { fg = colors.visual, bg = colors.bg } },
        replace = { a = { fg = colors.replace, bg = colors.bg } },
    }

    local lualine_config = {
        options = {
            icons_enabled = true,
            theme = theme,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
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
            },
        },
        sections = {
            lualine_a = {
                {
                    function()
                        return ""
                    end,
                },
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
                    "branch",
                    icon = "",
                    padding = { left = 2, right = 1 },
                },
                {
                    "diff",
                    diff_color = {
                        added = { fg = colors.normal },
                        modified = { fg = colors.visual },
                        removed = { fg = colors.replace },
                    },
                    symbols = { added = "", modified = "", removed = "" },
                    padding = 1,
                },
                {
                    function()
                        return "[" .. vim.bo.filetype .. "]"
                    end,
                    cond = function()
                        return vim.g.lualine_verbose
                    end,
                    color = "Keyword",
                },
                {
                    function()
                        return vim.fn.bufnr()
                    end,
                    icon = "",
                    cond = function()
                        return vim.g.lualine_verbose
                    end,
                    color = { fg = comment_fg },
                },
                {
                    function()
                        local words = vim.fn.wordcount()["words"]
                        return "wc: " .. words
                    end,
                    cond = function()
                        local ft = vim.opt_local.filetype:get()
                        local count = {
                            latex = true,
                            tex = true,
                            text = true,
                            markdown = true,
                            vimwiki = true,
                        }
                        return count[ft] ~= nil
                    end,
                    color = { fg = comment_fg },
                },
                {
                    -- https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/lualine.lua
                    function()
                        local isVisualMode = vim.fn.mode():find("[Vv]")
                        if not isVisualMode then
                            return ""
                        end
                        local starts = vim.fn.line("v")
                        local ends = vim.fn.line(".")
                        local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
                        return lines .. "L"
                    end,
                    color = { fg = comment_fg },
                },
            },
            lualine_c = {
                {
                    function()
                        return "%="
                    end,
                },
                {
                    "filetype",
                    icon_only = true,
                },
                {
                    "filename",
                    symbols = {
                        modified = "",
                        readonly = "",
                        unnamed = "[No Name]",
                        newfile = "",
                    },
                },
            },
            lualine_x = {},
            lualine_y = {
                {
                    "diagnostics",
                    symbols = {
                        error = " ",
                        warn = " ",
                        info = " ",
                        hint = " ",
                    },
                    -- symbols = {
                    --     error = '',
                    --     warn = '',
                    --     info = '',
                    --     hint = '',
                    -- },
                },
                {
                    function()
                        return ""
                    end,
                    color = { fg = colors.normal },
                    cond = function()
                        return vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil
                    end,
                },
                {
                    function()
                        local msg = "No Active Lsp"
                        local clients = vim.lsp.get_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        local clients_str = ""
                        for i, client in ipairs(clients) do
                            if i == 1 then
                                clients_str = clients_str .. client.name
                            else
                                clients_str = clients_str .. ", " .. client.name
                            end
                            -- local filetypes = client.config.filetypes
                            -- if filetypes and
                            --     vim.fn.index(filetypes, buf_ft) ~= -1 then
                            --     return client.name
                            -- end
                        end
                        return clients_str
                    end,
                    icon = "",
                },
            },
            lualine_z = {
                {
                    function()
                        return os.date("%H:%M")
                    end,
                    color = { fg = colors.normal },
                    padding = { left = 2, right = 1 },
                },
                {
                    function()
                        return require("pigeon.datetime").current_day()
                            .. " "
                            .. require("pigeon.datetime").current_date()
                    end,
                    cond = function()
                        return vim.g.lualine_verbose
                    end,
                    color = "Statement",
                },
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    }
    require("lualine").setup(lualine_config)
end

M.spec = {
    {
        "nvim-lualine/lualine.nvim",
        event = "LazyFile",
        dependencies = {
            {
                "Pheon-Dev/pigeon",
                config = pigeon_config,
            },
        },
        config = M.setup,
    },
}

return M
