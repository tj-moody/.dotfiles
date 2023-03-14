require('telescope').setup {
    pickers = {
        find_files = {
            hidden = true,
        },
    },
    defaults = {
        file_ignore_patterns = { '.git/' },
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = 'top',
            },
        },
        prompt_position = 'top',
        prompt_prefix = '  ',
        selection_caret = '  ',
        entry_prefix = '   ',
        sorting_strategy = 'ascending',
        -- winblend = 20,
    },
}
