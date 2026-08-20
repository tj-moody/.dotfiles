local M = {}
M.spec = {
    ---- LaTeX{{{1
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_compiler_method = "generic"
            vim.g.vimtex_compiler_generic = {
                command = "pdflatex -file-line-error -halt-on-error -interaction=nonstopmode -output-dir=out/ -synctex=1 @tex",
                out_dir = "out/",
                aux_dir = "out/",
            }
            vim.g.vimtex_compiler_clean_paths = { "out/*" }
        end,
    },
    ---- Typst{{{1
    {
        "kaarmu/typst.vim",
        ft = "typst",
    }, --}}}
}

return M
