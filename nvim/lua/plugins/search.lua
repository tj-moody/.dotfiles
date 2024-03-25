local M = {}
M.spec = {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        cmd = { 'Telescope', },
        dependencies = {
            { 'nvim-telescope/telescope-file-browser.nvim' },
            { 'nvim-lua/plenary.nvim' },
            {
                "danielfalk/smart-open.nvim",
                branch = "0.2.x",
                dependencies = {
                    { "kkharji/sqlite.lua" },
                    {
                        "nvim-telescope/telescope-fzf-native.nvim",
                        build = "make",
                    },
                    { "nvim-telescope/telescope-fzy-native.nvim" },
                },
            },
        },
        config = function()
            require('telescope').setup {
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
                file_browser = {
                    hijack_netrw = true,
                    -- mappings = {
                    --     ["i"] = {
                    --         -- your custom insert mode mappings
                    --     },
                    --     ["n"] = {
                    --         -- your custom normal mode mappings
                    --     },
                    -- },
                },
            }

            require('telescope').load_extension("smart_open")
            require("telescope").load_extension("file_browser")
        end,
    },
    {
        'junegunn/fzf.vim',
        dependencies = { 'junegunn/fzf', },
        cmd = { 'Rg', 'Buffers' },

        config = function()
            vim.g.fzf_layout = { ['down'] = '~30%' }
        end
    },
}

return M
