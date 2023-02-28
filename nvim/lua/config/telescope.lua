require('telescope').setup {
    defaults = {
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = 'top',
            },
        },
        prompt_position = 'top',
        sorting_strategy = 'ascending',
        winblend = 0,
    },
}
