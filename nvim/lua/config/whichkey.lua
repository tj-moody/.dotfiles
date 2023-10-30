require('which-key').setup {
    -- window = {
    --     winblend = 20,
    -- }
}

require('which-key').register {
    ["<leader>"] = {
        ["f"] = {
            name = "+find",
            ["f"] = "Files Fuzzy",
            ["h"] = "Highlights Fuzzy",
            ["g"] = "Grep",
            ["k"] = "Keymaps Fuzzy",
        },
        ["c"] = {
            name = "+comment",
            ["r"] = "Clear Registers",
            ["o"] = "Comment Below",
            ["O"] = "Comment Above",
            ["c"] = "Comment Line",
            ["l"] = "Append Comment",
        },
        ["d"] = {
            name = "+diagnostics",
            ["f"] = "Format File",
            ["h"] = "Hover Diagnostics",
            ["j"] = "Next Diagnostic",
            ["k"] = "Prev Diagnostic",
        },
        ["g"] = {
            name = "+git",
            ["d"] = "Diffview Toggle",
            ["j"] = "Next Git Hunk",
            ["k"] = "Prev Git Hunk",
            ["b"] = "Blame Line",
        },
        ["l"] = {
            name = "+lazy",
            ["g"] = "Lazygit Open",
            ["z"] = "Lazy Open",
        },
        ["p"] = {
            name = "+project",
            ["r"] = "Run Project",
            ["p"] = "Toggle Project",
            ["t"] = "Test Project",
            ["e"] = "Eval Under Cursor",
        },
        ["r"] = {
            name = "Rename",
            ["n"] = "Rename",
        },
        ["t"] = {
            name = "Tabs",
            ["a"] = "Toggle Alternate",
            ["."] = "Fuzzy Tab",
            ["n"] = "New T",
            ["L"] = "Next Tab",
            ["H"] = "Prev Tab",
            ["o"] = "Only Tab",
            ["q"] = "Quit Tab",
        },
        ["b"] = {
            name = "Buffer",
            ["d"] = "Delete Tab",
            ["p"] = "Pick Tab",
        },
        ["."] = "Fuzzy Split",
        ["R"] = "Restart Vim",
        ["y"] = "System Yank",
        ["="] = "Align File",
        ["o"] = "Only Window",
        ["O"] = "Only Buffer",
        ["q"] = "Quit",
        [","] = {
            name = "meta",
            ["x"] = "Source File",
            ["p"] = {
                name = "profiling",
                ["s"] = "Start Profiling",
                ["e"] = "End Profiling",

            },
        },
        ["z"] = { name = "Zen Mode" },
        ["C"] = { name = "Comment and Copy" },
    },
    ["C"] = {
        ["l"] = {
            name = "lsp-lines, verbose lualine",
            ["l"] = { name = "lsp-lines" },
            ["v"] = { name = "verbose lualine" },
        },
        ["r"] = {
            name = "relative number",
            ["n"] = "relative number",
        },
        ["w"] = { name = "wrap" },
        ["b"] = {
            name = "bufferline show all",
            ["a"] = "bufferline show all",
        },
        ["i"] = {
            name = "inlay hints",
            ["h"] = "inlay hints",
        },
        ["c"] = {
            name = "colorcolumn, conceallevel, colorscheme",
            ["c"] = "colorcolumn",
            ["l"] = "conceallevel",
            ["r"] = "reload theme",
        },
        ["v"] = {
            name = "virtual edit",
            ["e"] = "virtual edit",
        },
        ["g"] = {
            name = "git blame",
            ["b"] = "git blame",
        },
        ["t"] = { name = "theme" },
        ["d"] = { name = "terminal direction"}
    },
    ["g"] = {
        ["d"] = "Go to Definition",
        ["D"] = "Go to Declaration",
        ["I"] = "Go to Implementation",
        ["r"] = "Go to References",
        ["s"] = "Show Signature",
        ["j"] = "Next Equal Indent",
        ["k"] = "Prev Equal Indent",
        ["J"] = "Next Greater Indent",
        ["K"] = "Prev Greater Indent",
    },
    ["<SPACE>"] = {
        ["h"] = "Resize Left",
        ["j"] = "Resize Down",
        ["k"] = "Resize Up",
        ["l"] = "Resize Right",
    },
    ["d"] = {
        ["k"] = "Diagnostics Prev",
        ["j"] = "Diagnostics Next",
    },
    ["s"] = {
        ["l"] = "Split Right",
        ["j"] = "Split Down",
        ["e"] = "Equalize Splits",
    },
}
