local M = {}
M.spec = {
    {
        "ibhagwan/fzf-lua",
        keys = {
            { "<leader>ff", "<CMD>FzfLua files<CR>", desc = "Find File" },
            { "<leader>fg", "<CMD>FzfLua live_grep_native<CR>", desc = "Find File" },
            { "<leader>fb", "<CMD>FzfLua buffers<CR>", desc = "Find File" },
            { "<leader>fh", "<CMD>FzfLua highlights<CR>", desc = "Find File" },
            { "<leader>fk", "<CMD>FzfLua keymaps<CR>", desc = "Find File" },
            { "<leader>fc", "<CMD>FzfLua colorschemes<CR>", desc = "Find File" },
            { "<leader>fm", "<CMD>FzfLua helptags<CR>", desc = "Find Manual" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            grep = {
                -- previewer = "bat", -- Higher performance
            },
            winopts = {
                height = 0.35,
                width = 1.0,
                row = 1.0,
                col = 0.0,
                border = "border-top",
                preview = {
                    border = "border-top",
                },
                on_create = function()
                    vim.keymap.set("t", "<C-q>", function() end, { silent = true, buffer = true })
                end,
            },
            keymap = {
                fzf = {
                    ["ctrl-u"] = "half-page-up",
                    ["ctrl-d"] = "half-page-down",
                    ["ctrl-a"] = "toggle-all",
                },
            },
            fzf_opts = {
                ["--pointer"] = "",
                ["--marker"] = "┃",
            },
        },
    },
}

return M
