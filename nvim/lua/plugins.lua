local fun = {}
if vim.g.have_fun then
    fun = {
        {
            "giusgad/pets.nvim",
            event = 'VeryLazy',
            dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
            opts = {
                popup = { avoid_statusline = true },
            }
        },
    }
end
return {
    {
        event = 'VeryLazy',
        'xiyaowong/transparent.nvim',
        config = true,
    },
    {
        'aktersnurra/no-clown-fiesta.nvim',
        dependencies = {
            'rebelot/kanagawa.nvim',
            'sainnhe/gruvbox-material',
            'tj-moody/marsbox.nvim'
        },
        lazy = false,
        config = function() require("colorscheme").setup() end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        cmd = { 'Telescope', },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('config.telescope') end,
    },
    --- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-context' },
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
            { 'windwp/nvim-ts-autotag' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'Wansmer/treesj' },
        },
        config = function() require('config.treesitter') end,
    },
    --- LSP
    {
        'hrsh7th/nvim-cmp',
        event = 'VeryLazy',
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                config = function() require('config.lspconfig') end,
                dependencies = {
                    {
                        'williamboman/mason.nvim',
                        dependencies = 'williamboman/mason-lspconfig.nvim',
                        config = function() require('config.mason') end,
                    },
                    { 'folke/neodev.nvim' },
                    { 'ray-x/lsp_signature.nvim' },
                    { 'simrat39/rust-tools.nvim' },
                    { 'lvimuser/lsp-inlayhints.nvim',
                        branch = "anticonceal",
                    },
                },
            },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
            { 'onsails/lspkind.nvim' },
            config = function() require('config.cmp') end,
        },
    },
    {
        event = 'VeryLazy',
        "jose-elias-alvarez/null-ls.nvim",
        config = function() require('config.null-ls') end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "willothy/luahint",
        build = "cargo install --path=./",
        config = true
        -- or opts = { ... }
    },
    --- DAP
    --- UTILS
    {
        'tpope/vim-surround',
        event = 'VeryLazy',
    },
    -- TODO: Investigate - breaks default `%` for some reason? Investigate further
    -- {
    --     'andymass/vim-matchup',
    --     -- event = 'BufReadPost',
    --     event = 'VeryLazy',
    -- },
    {
        'rmagatti/auto-session',
        event = 'VeryLazy',
        cmd = { 'SessionRestore' },
        opts = {
            auto_save_enabled = true,
            auto_restore_enabled = false,
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        },
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        keys = { '<c-t>', },
        cmd = { 'ToggleTerm' },
        config = function()
            require('config.toggleterm'); require('colorscheme').setup('toggleterm')
        end,
    },
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function() require('config.comment') end,
    },
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        config = function()
            require("nvim-autopairs").setup(); vim.cmd [[set formatoptions-=cro]]
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function() require('config.colorizer') end,
    },
    {
        'mrjones2014/smart-splits.nvim',
        event = 'VeryLazy',
        config = function() require('config.smart-splits') end
    },
    {
        'chrisgrieser/nvim-various-textobjs',
        event = 'VeryLazy',
        config = function() require('config.various-textobjs') end
    },
    {
        'JellyApple102/flote.nvim',
        event = 'VeryLazy',
        config = function() require('config.flote') end
    },
    { 'RaafatTurki/hex.nvim',
        event = 'VeryLazy',
        config = true,
    },
    --- Git
    {
        'lewis6991/gitsigns.nvim',
        priority = 100,
        event = 'VeryLazy',
        config = true,
    },
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewClose', },
        dependencies = 'nvim-lua/plenary.nvim',
    },
    --- UI
    {
        'akinsho/bufferline.nvim',
        priority = 100,
        event = "VeryLazy",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function() require('config.bufferline') end,
    },
    {
        'nvim-lualine/lualine.nvim',
        priority = 100,
        event = 'VeryLazy',
        config = function() require('config.lualine') end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        cmd = { 'NvimTreeClose', 'NvimTreeToggle', },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('config.nvim-tree').nvim_tree_setup() end,
    },
    {
        'goolord/alpha-nvim',
        event = 'VimEnter',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('config.alpha') end
    },
    {
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        config = function() require('config.fidget') end
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function() require('config.whichkey') end,
    },
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        config = true,
    },
    --- Fun
    fun,
}
