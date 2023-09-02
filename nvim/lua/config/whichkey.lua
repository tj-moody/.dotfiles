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
            ["c"] = "Comment Line",
            ["u"] = "Uncomment Block",
            ["l"] = "Append Comment",
            ["j"] = "Next Diagnostic",
            ["k"] = "Prev Diagnostic",
        },
        ["d"] = {
            name = "+diagnostics",
            ["h"] = "Hover Diagnostics",
            ["f"] = "Format File",
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
            name = "terminal",
            ["f"] = "Float Term",
            ["j"] = "Down Term",
            ["l"] = "Right Term",
            ["a"] = "Toggle Alternate",
        },
        ["."] = "Fuzzy Split",
        ["R"] = "Restart Vim",
        ["y"] = "System Yank",
        ["="] = "Align File",
        ["o"] = "Only Window",
        ["O"] = "Only Buffer",
        ["q"] = "Quit",
        [","] = {
            --  TODO: Replace with more descriptive name as necessary
            name = "Source File",
            ["x"] = "Source File",
        }
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
            name = "colorcolumn, conceallevel",
            ["c"] = "colorcolumn",
            ["l"] = "conceallevel",
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
    ["T"] = {
        ["."] = "Fuzzy Tab",
        ["n"] = "New T",
        ["L"] = "Next Tab",
        ["H"] = "Prev Tab",
        ["o"] = "Only Tab",
        ["q"] = "Quit Tab",
        ["c"] = "Close Selected Tab",
        ["p"] = "Pick Tab",
    },
}
