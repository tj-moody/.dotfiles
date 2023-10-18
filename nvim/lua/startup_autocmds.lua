---- Enable spellcheck on gitcommit and markdown
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('Filetype Options', {}),
    pattern = { 'gitcommit', 'markdown', '*.txt' },
    callback = function(_)
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup("Lsp Start", {}),
    callback = function(args)
        local supported_filetypes = {
            "rust",
            "lua",
            "bash",
            "c",
            "cpp",
            "css",
            "html",
            "java",
            "json",
            "markdown",
            "vim",
            "asm",
            "tex",
        }
        for _, filetype in ipairs(supported_filetypes) do
            if vim.bo[args.buf].filetype == filetype then
                vim.cmd.LspStart()
            end
        end
    end
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('Filetype Options', {}),
    callback = function(args)
        vim.bo[args.buf].formatoptions = "jql"
    end,
})
