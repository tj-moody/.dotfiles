require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "help",
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
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },
    highlight = {
        enable = true,

        disable = {},
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
}
