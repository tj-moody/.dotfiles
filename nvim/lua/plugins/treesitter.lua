local M = {}
local function setup_treesitter()
    local ts = safe_require("nvim-treesitter")
    ---@diagnostic disable missing-fields
    -- safe_require("nvim-treesitter.parsers").get_parser_configs().asm = {
    --     install_info = {
    --         url = "https://github.com/rush-rs/tree-sitter-asm.git",
    --         files = { "src/parser.c" },
    --         branch = "main",
    --     },
    -- }

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
        pattern = { "*" },
        callback = function()
            local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

            if not parser_installed then
                require("nvim-treesitter").install({ parser_name }):wait(30000)
            end

            parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

            if parser_installed then
                vim.treesitter.start(bufnr, parser_name)
                vim.bo.syntax = 'on'
                -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo.foldmethod = 'expr'
            end
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
