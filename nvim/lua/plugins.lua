local fun = { -- {{{


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
    {
        'RRethy/nvim-base16',
        event = 'VeryLazy',
    },
} -- }}}
return {
    -- Colorscheme{{{1
    {
        'aktersnurra/no-clown-fiesta.nvim',
        dependencies = {
            'rebelot/kanagawa.nvim',
            'sainnhe/gruvbox-material',
            'folke/tokyonight.nvim',
            'EdenEast/nightfox.nvim',
            'catppuccin/nvim',
            'sainnhe/everforest',
            'AlexvZyl/nordic.nvim',
            'Shatur/neovim-ayu',
            'nyngwang/midnight-club.nvim',
        },
        config = function() safe_require("colorscheme").setup() end,
    }, -- }}}
    -- Search{{{1
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
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
    },
    {
        'junegunn/fzf.vim',
        dependencies = { 'junegunn/fzf', },
        event = 'VeryLazy',
        config = function()
            vim.g.fzf_layout = { ['down'] = '~30%' }
        end
    }, -- }}}
    -- Treesitter{{{1
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
        config = function() require('config.treesitter') end,
    }, -- }}}
    -- LSP{{{1
    {
        'hrsh7th/nvim-cmp',
        event = 'VeryLazy',
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                config = function()
                    safe_require('config.lspconfig')
                    vim.cmd.LspStart()
                end,
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
            { "lewis6991/hover.nvim", },
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
        "jose-elias-alvarez/null-ls.nvim",
        event = 'VeryLazy',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() safe_require('config.null-ls') end,
    }, -- }}}
    -- Languages{{{1
    ---- LaTeX{{{2
    {
        'lervag/vimtex',
        event = 'VeryLazy',
    },
    ---- Typst{{{2
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        event = "VeryLazy",
    },
    -- DAP {{{1
    -- }}}
    -- Utils{{{1
    {
        'tpope/vim-surround',
        event = 'VeryLazy',
    },
    {
        'rmagatti/auto-session',
        lazy = not vim.g.tj_reloaded,
        cmd = { 'SessionRestore', 'SessionSave' },
        config = function()
            require('auto-session').setup({ ---@diagnostic disable-line
                auto_save_enabled = false,
                auto_restore_enabled = false,
                log_level = "error",
                auto_session_suppress_dirs = {
                    "~/",
                    "~/Projects",
                    "~/Downloads",
                    "/",
                },
            })
            if vim.g.tj_reloaded then
                vim.cmd.SessionRestore()
            end
        end,
    },
    {
        dir = "~/projects/nucomment.nvim",
        config = { floating_comments = false },
        event = "VeryLazy",
    },
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        config = function()
            require("nvim-autopairs").setup {
                map_bs = false,
                disable_filetype = { "TelescopePrompt", "text" }
            }
            vim.opt.formatoptions = "rjql"
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function() safe_require('config.colorizer') end,
    },
    {
        'chrisgrieser/nvim-various-textobjs',
        event = 'VeryLazy',
        config = function() safe_require('config.various-textobjs') end
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
        'willothy/flatten.nvim',
        config = { window = { open = 'alternate' }, },
        priority = 1001,
        lazy = false,
    },
    {
        'chomosuke/term-edit.nvim',
        event = 'VeryLazy',
        version = '1.*',
        config = {
            prompt_end = ':: ',
        }
    },
    {
        'yuttie/comfortable-motion.vim',
        event = 'VeryLazy',
    },
    {
        "folke/trouble.nvim",
        event = 'VeryLazy',
        config = true,
    },
    {
        'willothy/wezterm.nvim',
        event = 'VeryLazy',
        config = true
    },
    {
        'mrjones2014/smart-splits.nvim',
        dependencies = { { 'numToStr/Navigator.nvim', config = true } },
        lazy = false,
        config = function() safe_require('config.smart-splits') end,
    },
    -- Git{{{1
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
    -- UI{{{1
    {
        'akinsho/bufferline.nvim',
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
        dependencies = { "Pheon-Dev/pigeon", },
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
        config = function()
            safe_require('config.alpha')
        end,
        cond = not vim.g.tj_reloaded,
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
            highlight = { multiline = true },
            keywords = {
                ["DONE"] = { icon = " ", color = "#b8bb26", },
                ["TODO"] = { icon = " ", color = "info" },
            },
        },
    },
    {
        'yorickpeterse/nvim-pqf',
        event = 'VeryLazy',
        config = true,
    },
    -- Project{{{1

    {
        dir = '~/projects/projtasks.nvim',
        dependencies = { 'akinsho/toggleterm.nvim' },
        event = 'VeryLazy',
        config = function() require('config.projtasks') end
    },
    -- }}}
    fun,
}
