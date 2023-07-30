local M = {}

function M.nvim_tree_setup()
    vim.g.nvimtreefloat = false
    safe_require('nvim-tree').setup {
        filters = {
            dotfiles = false,
        },
        renderer = {
            highlight_opened_files = "name",
        },
        view = {
            cursorline = false,
            mappings = {
                custom_only = false,
                list = {
                }
            },
        },
    }

    safe_require('colorscheme').clear_hl_bg('NvimTreeNormalNC')
    safe_require('colorscheme').clear_hl_bg('NvimTreeNormal')
    safe_require('colorscheme').clear_hl_bg('NvimTreeNormalFloat')
    safe_require('colorscheme').setup('nvim_tree')
end

function M.nvim_tree_float_setup()
    vim.g.nvimtreefloat = true
    local HEIGHT_RATIO = 0.8 -- You can change this
    local WIDTH_RATIO = 0.5  -- You can change this too

    require('nvim-tree').setup({
        view = {
            cursorline = false,
            float = {
                enable = true,
                open_win_config = function()
                    local screen_w = vim.opt.columns:get()
                    local screen_h = vim.opt.lines:get()
                        - vim.opt.cmdheight:get()
                    local window_w = screen_w * WIDTH_RATIO
                    local window_h = screen_h * HEIGHT_RATIO
                    local window_w_int = math.floor(window_w)
                    local window_h_int = math.floor(window_h)
                    local center_x = (screen_w - window_w) / 2
                    local center_y = ((vim.opt.lines:get() - window_h) / 2)
                        - vim.opt.cmdheight:get()
                    return {
                        border = 'single',
                        relative = 'editor',
                        row = center_y,
                        col = center_x,
                        width = window_w_int,
                        height = window_h_int,
                    }
                end,
            },
            width = function()
                return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
            end,
        },
    })

    local function set_float_bg(hl)
        local get_color = safe_require('colorscheme').get_color
        vim.api.nvim_set_hl(0, hl, {
            fg = get_color(hl, 'fg#'),
            bg = get_color('NormalFloat', 'bg#'),
        })
    end
    safe_require('colorscheme').setup('nvim_tree')
    set_float_bg('NvimTreeNormal')
    set_float_bg('NvimTreeNormalNC')
    set_float_bg('NvimTreeNormalFloat')
end

return M
