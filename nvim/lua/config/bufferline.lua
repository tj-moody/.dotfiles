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
        -- numbers = "none",
        numbers = function()
            return ''
        end,
        close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
        indicator = {
            icon = '▎',                    -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
            -- style = 'underline',
        },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true,  -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            -- return "("..count..")"
            -- return "" .. count
            return ""
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                text_align = "center",
                separator = ' ',
            },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        -- show_buffer_default_icon = true, -- deprecated
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = false,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        -- separator_style = "thick",
        separator_style = { ' ', ' ' },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' },
        },
        sort_by = 'insert_after_current',
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
