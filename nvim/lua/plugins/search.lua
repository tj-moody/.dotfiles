local M = {}
M.spec = {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.1.9",
        cmd = { "Telescope" },
        keys = {
            { "<leader>fd", ":cd ~/.dotfiles<CR> :Telescope file_browser<CR>", desc = "Find in Dotfiles" },
            { "<leader>fp", ":cd ~/projects<CR> :Telescope file_browser<CR>", desc = "Find Project" },
            { "<leader>ff", "<CMD>Telescope smart_open<CR>", desc = "Find File (smart)" },
            { "<leader>fh", "<CMD>Telescope highlights<CR>", desc = "Find Highlight" },
            { "<leader>fk", "<CMD>Telescope keymaps<CR>", desc = "Find Keymap" },
        },
        dependencies = {
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-lua/plenary.nvim" },
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
            safe_require("telescope").setup({
                pickers = {
                    find_files = {
                        layout_config = {
                            prompt_position = "top",
                        },
                    },
                },
                defaults = {
                    border = true,
                    file_ignore_patterns = { ".git/" },
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                        },
                    },
                    prompt_prefix = "  ",
                    selection_caret = "  ",
                    entry_prefix = "   ",
                    sorting_strategy = "ascending",
                },
                file_browser = {
                    hijack_netrw = true,
                },
            })

            safe_require("telescope").load_extension("smart_open")
            safe_require("telescope").load_extension("file_browser")
        end,
    },
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },
        keys = {
            { "<leader>fF", "<CMD>Files<CR>", desc = "Find File" },
            { "<leader>fg", "<CMD>Rg<CR>", desc = "Find Grep" },
            { "<leader>fb", "<CMD>Buffers<CR>", desc = "Find Buffer" },
        },

        config = function()
            vim.g.fzf_layout = { ["down"] = "~30%" }
        end,
    },
}

return M
