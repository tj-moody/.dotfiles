local M = {}
local function setup_treesitter()
    ---@diagnostic disable missing-fields
    safe_require("nvim-treesitter.parsers").get_parser_configs().asm = {
        install_info = {
            url = "https://github.com/rush-rs/tree-sitter-asm.git",
            files = { "src/parser.c" },
            branch = "main",
        },
    }

    safe_require("nvim-treesitter.configs").setup({
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

        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
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
                init_selection = "<C-e>",
                node_incremental = "<C-e>",
            },
        },
        autotag = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                },
                include_surrounding_whitespace = true,
            },
        },
    })

    vim.g.skip_ts_context_commentstring_module = true

    vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
end

M.spec = {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "LazyFile",
        dependencies = {
            { "windwp/nvim-ts-autotag" },
            { "JoosepAlviste/nvim-ts-context-commentstring", config = true },
            { "nvim-treesitter/nvim-treesitter-context", config = true },
            { "windwp/nvim-ts-autotag" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            {
                "Wansmer/treesj",
                config = { use_default_keymaps = false },
                keys = { { "<c-s>", "<CMD>TSJToggle<CR>", desc = "Split/Join" } },
            },
            { "nvim-treesitter/playground" },
            { "rush-rs/tree-sitter-asm" },
        },
        config = setup_treesitter,
    },
}

return M
