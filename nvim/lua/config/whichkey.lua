require('which-key').setup {
    -- window = {
    --     winblend = 20,
    -- }
}

require('which-key').register {
    ["<leader>"] = {
        ["f"] = { name = "+find", },
        ["c"] = { name = "+comment", },
        ["d"] = { name = "+diagnostics", },
        ["g"] = { name = "+git", },
        ["l"] = { name = "+lazy", },
        ["p"] = { name = "+project", },
        ["r"] = { name = "Rename", },
        ["t"] = { name = "Tabs", },
        ["b"] = { name = "Buffer", },
        ["."] = "Fuzzy Split",
        ["R"] = "Restart Vim",
        ["y"] = "System Yank",
        ["="] = "Align File",
        ["o"] = "Only Window",
        ["O"] = "Only Buffer",
        ["q"] = "Quit",
        [","] = {
            name = "meta",
            ["p"] = { name = "profiling", },
        },
        ["z"] = { name = "Zen Mode" },
        ["C"] = { name = "Comment and Copy" },
    },
    ["C"] = {
        ["l"] = { name = "lsp-lines, verbose lualine", },
        ["r"] = { name = "relative number", },
        ["w"] = { name = "wrap" },
        ["b"] = { name = "bufferline show all", },
        ["i"] = { name = "inlay hints", },
        ["c"] = { name = "colorcolumn, conceallevel, colorscheme", },
        ["v"] = { name = "virtual edit", },
        ["g"] = { name = "git blame", },
        ["t"] = { name = "theme" },
        ["d"] = { name = "terminal direction"}
    },
    ["g"] = { name = "Go", },
    ["<SPACE>"] = { name = "Move Window", },
    ["d"] = { name = "Diagnostics", },
    ["s"] = { name = "Splits", },
    ["x"] = { name = "QF List", },
}
