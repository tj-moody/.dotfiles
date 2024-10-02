local M = {}

local function setup_treesitter()
    ---@diagnostic disable missing-fields
    require("nvim-treesitter.parsers").get_parser_configs().asm = { -- {{{
        install_info = {
            url = "https://github.com/rush-rs/tree-sitter-asm.git",
            files = { "src/parser.c" },
            branch = "main",
        },
    } -- }}}

    require("nvim-treesitter.configs").setup({ -- {{{
        ensure_installed = {
            "c",
            "lua",
            "vim",
            -- "help",
            "rust",
            "javascript",
            "typescript",
            "python",
            "bash",
            "go",
            "html",
            "css",
            "java",
            "markdown",
            "norg",
            "asm",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        -- List of parsers to ignore installing (for "all")
        ignore_install = {},
        highlight = {
            enable = true,
            -- disable = {},
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

            additional_vim_regex_highlighting = true,
        },
        indent = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-SPACE>",
                -- scope_incremental = '',
                node_incremental = "<C-SPACE>",
                -- node_decremental = '',
            },
        },
        autotag = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    -- You can optionally set descriptions to the mappings (used in the desc parameter of
                    -- nvim_buf_set_keymap) which plugins like which-key display
                    ["ic"] = {
                        query = "@class.inner",
                        desc = "Select inner part of a class region",
                    },
                    -- You can also use captures from other query groups like `locals.scm`
                    ["as"] = {
                        query = "@scope",
                        query_group = "locals",
                        desc = "Select language scope",
                    },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    ["@class.outer"] = "<c-v>", -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = true,
            },
        },
    }) -- }}}

    require("treesitter-context").setup({ -- {{{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
                "class",
                "function",
                "method",
                "for",
                "while",
                "if",
                "switch",
                "case",
                "interface",
                "struct",
                "enum",
            },
            -- Patterns for specific filetypes
            -- If a pattern is missing, *open a PR* so everyone can benefit.
            tex = {
                "chapter",
                "section",
                "subsection",
                "subsubsection",
            },
            haskell = {
                "adt",
            },
            rust = {
                "impl_item",
            },
            terraform = {
                "block",
                "object_elem",
                "attribute",
            },
            scala = {
                "object_definition",
            },
            vhdl = {
                "process_statement",
                "architecture_body",
                "entity_declaration",
            },
            markdown = {
                "section",
            },
            elixir = {
                "anonymous_function",
                "arguments",
                "block",
                "do_block",
                "list",
                "map",
                "tuple",
                "quoted_content",
            },
            json = {
                "pair",
            },
            typescript = {
                "export_statement",
            },
            yaml = {
                "block_mapping_pair",
            },
        },
        exact_patterns = {
            -- Example for a specific filetype with Lua patterns
            -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
            -- exactly match "impl_item" only)
            -- rust = true,
        },

        -- [!] The options below are exposed but shouldn't require your attention,
        --     you can safely ignore them.

        zindex = 20, -- The Z-index of the context window
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
    }) -- }}}

    require("treesj").setup({ -- {{{
        use_default_keymaps = false,
    }) -- }}}

    require("ts_context_commentstring").setup({})
    vim.g.skip_ts_context_commentstring_module = true

    vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
end

M.spec = {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-context" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "windwp/nvim-ts-autotag" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "Wansmer/treesj" },
            { "nvim-treesitter/playground" },
            { "rush-rs/tree-sitter-asm" },
        },
        config = setup_treesitter,
    },
}

return M
