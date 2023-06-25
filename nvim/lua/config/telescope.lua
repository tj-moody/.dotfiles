local telescope = require('telescope')
telescope.setup {
    pickers = {
        find_files = {
            layout_config = {
                prompt_position = 'top',
            },
        },
    },
    defaults = {
        file_ignore_patterns = { '.git/' },
        layout_config = {
            -- prompt_position = 'top',
            horizontal = {
                prompt_position = 'top',
            },
        },
        prompt_prefix = '  ',
        selection_caret = '  ',
        entry_prefix = '   ',
        sorting_strategy = 'ascending',
        -- winblend = 20,
    },
}

telescope.load_extension("smart_open")
