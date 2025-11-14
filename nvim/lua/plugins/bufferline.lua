local M = {}

M.setup = function()
    local bgcolor = ""
    local tabline_sel_bg = "#a2b5c1"
    vim.api.nvim_set_hl(0, "TabLineSel", { fg = tabline_sel_bg })

    -- local get_color = safe_require("plugins.colorscheme").get_color
    -- local error_color = get_color('DiagnosticError', 'fg#')
    -- local warning_color = get_color('DiagnosticWarn', 'fg#')
    -- local hint_color = get_color('DiagnosticHint', 'fg#')
    -- local info_color = getrcolor('DiagnosticInfo', 'fg#')

    ---@diagnostic disable missing-fields
    safe_require("bufferline").setup({
        options = {
            style_preset = safe_require("bufferline").style_preset.minimal,
            custom_filter = function(buf)
                local num = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
                if num > 1 then
                    return true
                end

                return false
            end,
            mode = "buffers",
            numbers = function()
                return ""
            end,
            indicator = {
                icon = "▎", -- this should be omitted if indicator style is not 'icon'
                style = "icon",
            },
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "",
                    text_align = "center",
                    separator = " ",
                },
                {
                    filetype = "markdown.projpad",
                    text = "",
                    text_align = "center",
                    separator = " ",
                },
            },
            separator_style = { " ", " " },
        },
        highlights = { -- {{{
            fill = { bg = bgcolor },
            background = { bg = bgcolor },
            tab = { bg = bgcolor },
            tab_selected = {
                fg = tabline_sel_bg,
                bg = bgcolor,
            },
            tab_separator = { bg = bgcolor },
            tab_separator_selected = { bg = bgcolor },
            close_button = { bg = bgcolor },
            close_button_visible = { bg = bgcolor },
            close_button_selected = { bg = bgcolor },
            buffer_visible = {
                bg = bgcolor,
                bold = true,
                italic = false,
            },
            buffer_selected = {
                bg = bgcolor,
                bold = true,
                italic = false,
            },
            numbers_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            diagnostic_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            numbers = { bg = bgcolor },
            numbers_visible = { bg = bgcolor },
            diagnostic = { bg = bgcolor },
            diagnostic_visible = { bg = bgcolor },
            hint = {
                -- sp = bgcolor,
                bg = "",
            },
            hint_visible = { bg = bgcolor },
            hint_selected = {
                bg = bgcolor,
                -- sp = '',
                bold = true,
                italic = true,
            },
            hint_diagnostic = {
                -- sp = bgcolor,
                bg = "",
            },
            hint_diagnostic_visible = {
                bg = bgcolor,
            },
            hint_diagnostic_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            info = {
                -- sp = bgcolor,
                bg = "",
            },
            info_visible = { bg = bgcolor },
            info_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            info_diagnostic = {
                -- sp = bgcolor,
                bg = "",
            },
            info_diagnostic_visible = { bg = bgcolor },
            info_diagnostic_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            warning = {
                -- sp = bgcolor,
                bg = "",
            },
            warning_visible = { bg = bgcolor },
            warning_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            warning_diagnostic = {
                -- sp = bgcolor,
                bg = "",
            },
            warning_diagnostic_visible = { bg = bgcolor },
            warning_diagnostic_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            error = {
                bg = bgcolor,
                -- sp = '',
            },
            error_visible = {
                bg = bgcolor,
            },
            error_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            error_diagnostic = {
                bg = bgcolor,
                -- sp = '',
            },
            error_diagnostic_visible = { bg = bgcolor },
            error_diagnostic_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            modified = { bg = bgcolor },
            modified_visible = { bg = bgcolor },
            modified_selected = {
                bg = bgcolor,
                italic = true,
            },
            duplicate_selected = {
                bg = bgcolor,
                italic = true,
            },
            duplicate_visible = {
                bg = bgcolor,
                italic = true,
            },
            duplicate = {
                bg = bgcolor,
                italic = true,
            },
            separator_selected = { bg = bgcolor },
            separator_visible = {
                fg = bgcolor,
                bg = bgcolor,
            },
            separator = {
                fg = bgcolor,
                bg = bgcolor,
            },
            indicator_selected = {
                fg = bgcolor,
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            indicator_visible = {
                fg = bgcolor,
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            pick_selected = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            pick_visible = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            pick = {
                bg = bgcolor,
                bold = true,
                italic = true,
            },
            offset_separator = { bg = bgcolor },
        }, -- }}}
    })

    vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible", { fg = "#bad7ff" })
    vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = "#bad7ff" })
end

M.spec = {
    {
        "akinsho/bufferline.nvim",
        event = "LazyFile",
        keys = {
            { "H", "<CMD>BufferLineCyclePrev<CR>", desc = "Previous Buffer" },
            { "L", "<CMD>BufferLineCycleNext<CR>", desc = "Next Buffer" },
            { "<leader>bc", "<CMD>BufferLinePickClose<CR>", desc = "Close Buffer" },
            { "<leader>bp", "<CMD>BufferLinePick<CR>", desc = "Pick Buffer" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "sainnhe/gruvbox-material",
        },
        config = M.setup,
    },
}

return M
