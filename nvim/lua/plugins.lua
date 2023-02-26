return {
    {

        'aktersnurra/no-clown-fiesta.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require("colorscheme").setup()
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
    },
    {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        config = function()
            require('config.telescope')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = "VeryLazy",
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-context' },
            {'JoosepAlviste/nvim-ts-context-commentstring'},
            {'windwp/nvim-ts-autotag'},
        },
        config = function()
            require('config.treesitter')
        end,
    },
    --- LSP
    --- DAP
    --- UTILS
    {
        'rmagatti/auto-session',
        opts = {
            auto_save_enabled = true,
            auto_restore_enabled = false,
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
        },
    },
    {
        'akinsho/toggleterm.nvim', version = '*',
        cmd = { "ToggleTerm" },
        config = function()
            require('config.toggleterm')
            require('colorscheme').setup('toggleterm')
        end,
    },
    {
        'numToStr/Comment.nvim',
        event = "BufEnter",
        config = function()
            require('config.comment')
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "BufEnter",
        config = true,
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = "BufEnter",
        config = function()
            require('config.colorizer')
        end,
    },
    {
        'mrjones2014/smart-splits.nvim',
        event = "VeryLazy",
        config = function()
            require('config.smart-splits')
        end
    },
    --- UI
    {
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('config.bufferline')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        config = function()
            require('config.lualine')
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('config.nvim-tree').nvim_tree_setup()
        end,
    },
    {
        'rmagatti/auto-session',
        opts = {
              auto_save_enabled = true,
              auto_restore_enabled = false,
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
        },
    },
    {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('config.alpha')
        end
    },
}
