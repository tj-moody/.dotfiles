local tabline_sel_bg = '#a2b5c1'
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = tabline_sel_bg, })

-- local get_color = safe_require("colorscheme").get_color
-- local error_color = get_color('DiagnosticError', 'fg#')
-- local warning_color = get_color('DiagnosticWarn', 'fg#')
-- local hint_color = get_color('DiagnosticHint', 'fg#')
-- local info_color = getrcolor('DiagnosticInfo', 'fg#')

require("bufferline").setup {
    options = {
        custom_filter = function(buf)
            if vim.g.bufferline_show_all then
                return true
            end
            local tab_num = 0
            for _ in pairs(vim.api.nvim_list_tabpages()) do
                tab_num = tab_num + 1
            end
            if tab_num == 1 then
                return true
            end
            for _, v in ipairs(vim.fn.tabpagebuflist()) do
                if buf == v then
                    return true
                end
            end
            return false
        end,
        mode = "buffers",
        numbers = function()
            return ''
        end,
        indicator = {
            icon = '▎',                    -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                text_align = "center",
                separator = ' ',
            },
        },
        separator_style = { ' ', ' ' },
        custom_areas = {
            left = function()
                return { { text = ' ', bg = '', fg = '', } }
            end,
            -- FIX: All diagnostics only use hint color
            -- right = function()
            --     local result = {}
            --     local seve = vim.diagnostic.severity
            --     local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            --     local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            --     local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            --     local hint = #vim.diagnostic.get(0, { severity = seve.HINT })
            --     -- local get_color = safe_require("colorscheme").get_color
            --     -- local error_color = get_color('DiagnosticError', 'fg#')
            --     -- local warning_color = get_color('DiagnosticWarn', 'fg#')
            --     -- local hint_color = get_color('DiagnosticHint', 'fg#')
            --     -- local info_color = get_color('DiagnosticInfo', 'fg#')
            --     if error ~= 0 then table.insert(result, { text = "  " .. error, fg = error_color }) end
            --     if warning ~= 0 then table.insert(result, { text = "  " .. warning, fg = warning_color }) end
            --     if hint ~= 0 then table.insert(result, { text = "  " .. hint, fg = hint_color }) end
            --     if info ~= 0 then table.insert(result, { text = "  " .. info, fg = info_color }) end
            --     return result
            -- end,
        },
    },
}

vim.api.nvim_set_hl(0, 'BufferLineIndicatorVisible', { fg = '#bad7ff' })
vim.api.nvim_set_hl(0, 'BufferLineIndicatorSelected', { fg = '#bad7ff' })
