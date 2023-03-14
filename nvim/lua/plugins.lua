return {
    {

        'aktersnurra/no-clown-fiesta.nvim',
        dependencies = {
            'rebelot/kanagawa.nvim',
        },
        lazy = false,
        config = function()
            require("colorscheme").setup()
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('config.telescope')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = "VeryLazy",
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-context' },
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
            { 'windwp/nvim-ts-autotag' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
        },
        config = function()
            require('config.treesitter')
        end,
    },
    --- LSP
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('config.mason')
        end,
    },
    {
        'williamboman/mason.nvim',
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('config.lspconfig')
        end,
        dependencies = {
            { 'williamboman/mason.nvim', },
            { 'folke/neodev.nvim' },
            { 'ray-x/lsp_signature.nvim' },
            { 'simrat39/rust-tools.nvim' },
        },
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'VeryLazy',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
            { 'onsails/lspkind.nvim' },
        },
        config = function()
            require('config.cmp')
        end,
    },
    --- DAP
    --- UTILS
    {
        'tpope/vim-surround',
    },
    {
        'rmagatti/auto-session',
        opts = {
            auto_save_enabled = true,
            auto_restore_enabled = false,
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        },
    },
    {
        'akinsho/toggleterm.nvim', version = '*',
        -- cmd = { "ToggleTerm" },
        keys = { '<c-t>', },
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
        config = function()
            require("nvim-autopairs").setup()
            vim.cmd [[set formatoptions-=cro]]
        end,
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
    {
        'chrisgrieser/nvim-various-textobjs',
        config = function()
            require('config.various-textobjs')
        end
    },
    --- Git
    {
        'lewis6991/gitsigns.nvim',
        config = true,
    },
    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
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
        event = 'VeryLazy',
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
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
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
        'j-hui/fidget.nvim',
        config = function()
            require('config.fidget')
        end
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            require('config.whichkey')
        end,
    },
}
