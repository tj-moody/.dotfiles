local M = {}
M.spec = {
    ---- LaTeX{{{1
    {
        'lervag/vimtex',
        event = 'VeryLazy',
    },
    ---- Typst{{{1
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        event = "VeryLazy",
    }, --}}}
}

return M
