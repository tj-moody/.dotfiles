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
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('config.bufferline')
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = true,
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
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('config.treesitter')
        end
    },
}
