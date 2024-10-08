local M = {}
M.spec = {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local get_fortune = require("alpha.fortune")

            local headers = require("plugins.assets.headers")

            local function button(sc, txt, keybind, keybind_opts)
                local sc_ = sc:gsub("%s", ""):gsub("LDR", "<leader>"):gsub("SPC", "<space>")

                local opts = {
                    position = "center",
                    shortcut = sc,
                    cursor = 5,
                    width = 50,
                    align_shortcut = "right",
                    hl_shortcut = "Conditional",
                }
                if keybind then
                    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
                    opts.keymap = { "n", sc_, keybind, keybind_opts }
                end

                local function on_press()
                    local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
                    vim.api.nvim_feedkeys(key, "normal", false)
                end

                return {
                    type = "button",
                    val = txt,
                    on_press = on_press,
                    opts = opts,
                }
            end

            local header = {
                type = "text",
                val = headers[1],
                opts = {
                    position = "center",
                    hl = "AlphaHeader",
                    -- wrap = "overflow";
                },
            }

            local buttons = {
                type = "group",
                val = {
                    button("f", "  Find file", ":Telescope smart_open<CR>"),
                    button("r", "勒 Restore Session", ":SessionRestore<CR>"),
                    button("L", "鈴 Lazy", ":Lazy<CR>"),
                    button("S", "  Sync", ":Lazy sync<CR>"),
                    button("P", "󰾆  Profile", ":Lazy profile<CR>"),
                    button("q", "  Quit", ":qa<CR>"),
                    --  
                },
                opts = {
                    spacing = 1,
                },
            }

            local function get_footer1()
                local datetime = os.date(" %m-%d   %H:%M")
                local version = vim.version()
                local nvim_version_info = " v" .. version.major .. "." .. version.minor .. "." .. version.patch

                return datetime .. " " .. nvim_version_info
            end

            local footer = {
                type = "group",
                val = {
                    {
                        type = "text",
                        val = get_footer1(),
                        opts = {
                            position = "center",
                            hl = "AlphaFooter1",
                        },
                    },
                    {
                        type = "text",
                        val = "  " .. require("lazy").stats().count,
                        opts = {
                            position = "center",
                            hl = "AlphaFooter1",
                        },
                    },
                },
            }
            local fortune = {
                type = "text",
                val = get_fortune(),
                opts = {
                    position = "center",
                },
            }

            local opts = {
                layout = {
                    { type = "padding", val = 1 },
                    header,

                    { type = "padding", val = 1 },
                    buttons,

                    { type = "padding", val = 1 },

                    footer,
                    fortune,
                    -- { type = "padding", val = bottom_padding },
                },
                opts = {
                    margin = 5,
                },
            }

            require("alpha").setup(opts)

            safe_require("plugins.colorscheme").setup("alpha")

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    footer.val[2].val = " " .. require("lazy").stats().count .. " plugins  󱑎 " .. ms .. "ms"
                    safe_require("plugins.colorscheme").setup("alpha")
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
        cond = not vim.g.tj_reloaded,
    },
}

return M
