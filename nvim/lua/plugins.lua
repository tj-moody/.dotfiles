local fun = {}
fun = {-- {{{
    {
        "giusgad/pets.nvim",
        event = 'VeryLazy',
        dependencies = {
            "MunifTanjim/nui.nvim",
            "giusgad/hologram.nvim",
        },
        opts = {
            popup = { avoid_statusline = true },
        },
        cond = vim.g.have_fun,
    },
}-- }}}
return {
    --- Colorscheme{{{
    {
        'aktersnurra/no-clown-fiesta.nvim',
        dependencies = {
            'rebelot/kanagawa.nvim',
            'sainnhe/gruvbox-material',
            'tj-moody/marsbox.nvim',
            'folke/tokyonight.nvim',
            'EdenEast/nightfox.nvim',
            'catppuccin/nvim',
            'sainnhe/everforest',
            'AlexvZyl/nordic.nvim',
            'Shatur/neovim-ayu',
            'nyngwang/midnight-club.nvim',
        },
        lazy = false,
        config = function() safe_require("colorscheme").setup() end,
    },-- }}}
    --- Telescope{{{
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        cmd = { 'Telescope', },
        dependencies = {
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
        config = function() safe_require('config.telescope') end,
    },-- }}}
    --- Treesitter{{{
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-context' },
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
            { 'windwp/nvim-ts-autotag' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'Wansmer/treesj' },
            { 'nvim-treesitter/playground' },
            { 'rush-rs/tree-sitter-asm' },
        },
        config = function() safe_require('config.treesitter') end,
    },-- }}}
    --- LSP{{{
    {
        'hrsh7th/nvim-cmp',
        event = 'VeryLazy',
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                config = function() safe_require('config.lspconfig') end,
                dependencies = {
                    {
                        'williamboman/mason.nvim',
                        dependencies = 'williamboman/mason-lspconfig.nvim',
                        config = function() safe_require('config.mason') end,
                    },
                    { 'folke/neodev.nvim' },
                    { 'ray-x/lsp_signature.nvim' },
                    { 'simrat39/rust-tools.nvim' },
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
            config = function() safe_require('config.cmp') end,
        },
    },
    {
        event = 'VeryLazy',
        "jose-elias-alvarez/null-ls.nvim",
        config = function() safe_require('config.null-ls') end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },-- }}}
    --- DAP
    --- UTILS{{{
    {
        'tpope/vim-surround',
        event = 'VeryLazy',
    },
    -- TODO: Investigate - breaks default `%` for some reason?
    -- {
    --     'andymass/vim-matchup',
    --     -- event = 'BufReadPost',g
    --     event = 'VeryLazy',
    -- },
    {
        'rmagatti/auto-session',
        cmd = { 'SessionRestore', 'SessionSave' },
        opts = {
            auto_save_enabled = false,
            auto_restore_enabled = false,
            log_level = "error",
            auto_session_suppress_dirs = {
                "~/",
                "~/Projects",
                "~/Downloads",
                "/",
            },
        },
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            safe_require('config.toggleterm')
            safe_require('colorscheme').setup('toggleterm')
        end,
    },
    {
        'tj-moody/vim-commentary',
        event = 'VeryLazy',
    },
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        config = function()
            require("nvim-autopairs").setup { map_bs = false }
            vim.cmd [[set formatoptions-=cro]]
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function() safe_require('config.colorizer') end,
    },
    {
        'mrjones2014/smart-splits.nvim',
        event = 'VeryLazy',
        config = function() safe_require('config.smart-splits') end
    },
    {
        'chrisgrieser/nvim-various-textobjs',
        event = 'VeryLazy',
        config = function() safe_require('config.various-textobjs') end
    },
    {
        'JellyApple102/flote.nvim',
        cmd = { 'Flote' },
        config = function() safe_require('config.flote') end
    },
    {
        'RaafatTurki/hex.nvim',
        event = 'VeryLazy',
        config = true,
    },
    {
        'tommcdo/vim-lion',
        event = 'VeryLazy',
    },
    {
        'rmagatti/alternate-toggler',
        cmd = { 'ToggleAlternate' },
        config = function() safe_require('config.alternate-toggler') end,
    },
    {
        'tj-moody/projtasks.nvim',
        dependencies = { 'akinsho/toggleterm.nvim' },
        cmd = { 'ProjtasksToggle', 'ProjtasksRun', 'ProjtasksTest', },
        config = { direction = "vertical" },
    },
    {
        'michaelb/sniprun',
        build = 'sh ./install.sh',
        config = function()
            vim.api.nvim_set_hl(0, 'SniprunVirtualTextOk',
                {
                    fg = safe_require('colorscheme')
                        .get_color('SniprunVirtualTextOk', 'bg#')
                })
        end,
        event = 'VeryLazy',
    },
    {
        'willothy/flatten.nvim',
        config = {
            window = { open = 'alternate' },
        },
        lazy = false,
    },-- }}}
    --- Git{{{
    {
        'lewis6991/gitsigns.nvim',
        priority = 100,
        event = 'VeryLazy',
        config = true,
    },
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {
        "FabijanZulj/blame.nvim",
        event = 'VeryLazy',
    },-- }}}
    --- UI{{{
    {
        'akinsho/bufferline.nvim',
        priority = 100,
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'aktersnurra/no-clown-fiesta.nvim'
        },
        config = function() safe_require('config.bufferline') end,
    },
    {
        'nvim-lualine/lualine.nvim',
        priority = 100,
        event = 'VeryLazy',
        config = function() safe_require('config.lualine') end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        cmd = { 'NvimTreeClose', 'NvimTreeToggle', },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            safe_require('config.nvim-tree').nvim_tree_setup()
        end,
    },
    {
        'goolord/alpha-nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() safe_require('config.alpha') end
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'VeryLazy',
        config = function() safe_require('config.fidget') end
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function() safe_require('config.whichkey') end,
    },
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        config = {
            highlight = { multiline = false },
            keywords = {
                ["DONE"] = { icon = " ", color = "#b8bb26", },
                ["TODO"] = { icon = " ", color = "info" },
            },
        },
    },
    {
        'karb94/neoscroll.nvim',
        event = 'VeryLazy',
        config = true,
    },-- }}}
    fun,
}
