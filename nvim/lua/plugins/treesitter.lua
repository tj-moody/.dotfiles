local M = {}
local function setup_treesitter()
    local ts = safe_require("nvim-treesitter")

    ts.install({
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
        "asm",
    }, {
        summary = false,
    })

    vim.g.skip_ts_context_commentstring_module = true

    vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
    vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
            -- vim.treesitter.start(ev.buf)
            -- pcall(vim.treesitter.start)
            vim.bo[ev.buf].syntax = "ON"
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })
end

M.spec = {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        event = "LazyFile",
        dependencies = {
            { "windwp/nvim-ts-autotag" },
            { "nvim-treesitter/nvim-treesitter-context", config = true },
            { "JoosepAlviste/nvim-ts-context-commentstring", config = true },
            -- { "nvim-treesitter/nvim-treesitter-textobjects" },
            -- { "nvim-treesitter/playground" },
            {
                "Wansmer/treesj",
                config = { use_default_keymaps = false },
                keys = { { "<c-s>", "<CMD>TSJToggle<CR>", desc = "Split/Join" } },
            },
            { "rush-rs/tree-sitter-asm" },
        },
        config = setup_treesitter,
    },
}

return M
