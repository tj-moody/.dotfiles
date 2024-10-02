---- Enable spellcheck on gitcommit and markdown
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("Filetype Options", {}),
    pattern = { "gitcommit", "markdown", "*.txt" },
    callback = function(_)
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = vim.api.nvim_create_augroup("Filetype Options", {}),
    callback = function()
        vim.opt.formatoptions = "rjql"
    end,
    desc = "Disable New Line Comment",
})
