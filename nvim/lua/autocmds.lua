vim.api.nvim_create_autocmd('Filetype', {
    callback = function(opts)
        vim.cmd("set formatoptions-=cro")
    end,
})
