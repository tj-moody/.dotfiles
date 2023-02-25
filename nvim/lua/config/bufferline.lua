local bgcolor = require("utils").getcolor('Normal', 'bg#')
require("bufferline").setup{
    options = {
        mode = "buffers",
        numbers = "none",
        close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            -- style = 'icon',
            style = 'underline',
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
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                text_align = "center",
                separator = true,
            },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_buffer_default_icon = true,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = false,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = { ' ', ' ' },
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'},
        },
        sort_by = 'insert_after_current',
    },
    highlights = {
        fill = {
            fg = '',
            bg = bgcolor,
        },
        background = {
            fg = '',
            bg = bgcolor
        },
        tab = {
            fg = '',
            bg = bgcolor
        },
        tab_selected = {
            fg = tabline_sel_bg,
            bg = bgcolor
        },
        tab_close = {
            fg = '',
            bg = bgcolor
        },
        close_button = {
            fg = '',
            bg = bgcolor
        },
        close_button_visible = {
            fg = '',
            bg = bgcolor
        },
        close_button_selected = {
            fg = '',
            bg = bgcolor
        },
        buffer_visible = {
            fg = '',
            bg = bgcolor,
            bold = true,
            italic = true,
            underline = true,
        },
        buffer_selected = {
            fg = normal_fg,
            bg = bgcolor,
            bold = true,
            italic = true,
            underline = true,
        },
        numbers = {
            fg = '',
            bg = bgcolor,
        },
        numbers_visible = {
            fg = '',
            bg = bgcolor,
        },
        numbers_selected = {
            fg = '',
            bg = bgcolor,
            bold = true,
            italic = true,
        },
        diagnostic = {
            fg = '',
            bg = bgcolor,
        },
        diagnostic_visible = {
            fg = '',
            bg = bgcolor,
        },
        diagnostic_selected = {
            fg = '',
            bg = bgcolor,
            bold = true,
            italic = true,
        },
        hint = {
            fg = '',
            sp = bgcolor,
            bg = ''
        },
        hint_visible = {
            fg = '',
            bg = bgcolor
        },
        hint_selected = {
            fg = '',
            bg = bgcolor,
            sp = '',
            bold = true,
            italic = true,
        },
        hint_diagnostic = {
            fg = '',
            sp = bgcolor,
            bg = ''
        },
        hint_diagnostic_visible = {
            fg = '',
            bg = bgcolor
        },
        hint_diagnostic_selected = {
            fg = '',
            bg = bgcolor,
            sp = '',
            bold = true,
            italic = true,
        },
        info = {
            fg = '',
            sp = bgcolor,
            bg = '',
        },
        info_visible = {
            fg = '',
            bg = bgcolor,
        },
        info_selected = {
            fg = '',
            bg = bgcolor,
            sp = '',
            bold = true,
            italic = true,
        },
        info_diagnostic = {
            fg = '',
            sp = bgcolor,
            bg = '',
        },
        info_diagnostic_visible = {
            fg = '',
            bg = bgcolor,
        },
        info_diagnostic_selected = {
            fg = '',
            bg = bgcolor,
            sp = '',
            bold = true,
            italic = true,
        },
        warning = {
            fg = '',
            sp = bgcolor,
            bg = '',
        },
        warning_visible = {
            fg = '',
            bg = bgcolor,
        },
        warning_selected = {
            fg = '',
            bg = bgcolor,
            sp = '',
            bold = true,
            italic = true,
        },
        warning_diagnostic = {
            fg = '',
            sp = bgcolor,
            bg = '',
        },
        warning_diagnostic_visible = {
            fg = '',
            bg = bgcolor,
        },
        warning_diagnostic_selected = {
            fg = '',
            bg = bgcolor,
            sp = '',
            bold = true,
            italic = true,
        },
        error = {
            fg = '',
            bg = bgcolor,
            sp = '',
        },
        error_visible = {
            fg = '',
            bg = bgcolor,
        },
        error_selected = {
            fg = '',
            bg = bgcolor,
            sp = '',
            bold = true,
            italic = true,
        },
        error_diagnostic = {
            fg = '',
            bg = bgcolor,
            sp = '',
        },
        error_diagnostic_visible = {
            fg = '',
            bg = bgcolor,
        },
        error_diagnostic_selected = {
            fg = '',
            bg = bgcolor,
            sp = '',
            bold = true,
            italic = true,
        },
        modified = {
            fg = '',
            bg = bgcolor,
        },
        modified_visible = {
            fg = '',
            bg = bgcolor,
        },
        modified_selected = {
            fg = '',
            bg = bgcolor,
        },
        duplicate_selected = {
            fg = '',
            bg = bgcolor,
            italic = true,
        },
        duplicate_visible = {
            fg = '',
            bg = bgcolor,
            italic = true
        },
        duplicate = {
            fg = '',
            bg = bgcolor,
            italic = true
        },
        separator_selected = {
            fg = '',
            bg = bgcolor,
        },
        separator_visible = {
            fg = '',
            bg = bgcolor,
        },
        separator = {
            fg = '',
            bg = bgcolor,
        },
        indicator_selected = {
            fg = '',
            bg = bgcolor,
        },
        pick_selected = {
            fg = '',
            bg = bgcolor,
            bold = true,
            italic = true,
        },
        pick_visible = {
            fg = '',
            bg = bgcolor,
            bold = true,
            italic = true,
        },
        pick = {
            fg = '',
            bg = bgcolor,
            bold = true,
            italic = true,
        },
        offset_separator = {
            fg = '',
            bg = bgcolor,
        },
    }
}
vim.api.nvim_set_hl(0, 'BufferLineIndicatorVisible', {fg = '#bad7ff'})
vim.api.nvim_set_hl(0, 'BufferLineIndicatorSelected', {fg = '#bad7ff'})
