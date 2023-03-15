vim.api.nvim_create_autocmd('Filetype', {
    callback = function(opts)
        vim.cmd("set formatoptions-=cro")
    end,
})
-- vim.api.nvim_create_autocmd('BufEnter', {
--     callback = function(opts)
--     local window_id = win_getid()
--         if vim.api.nvim_win_get_config(window_id).relative ~= '' then
--             vim.diagnostic.config({ virtual_lines = false })
--         end
--     end,
-- })
vim.api.nvim_create_autocmd('Filetype', {
    callback = function(opts)
        vim.cmd("set formatoptions-=cro")
    end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1
        if not directory then
            return
        end

        vim.cmd.cd(data.file)
        require("nvim-tree.api").tree.open()
    end
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CursorHold' }, {
    callback = function(opts)
        vim.cmd('LspStart')
    end,
})

vim.api.nvim_create_autocmd( 'ExitPre', {
    callback = function(opts)
        vim.cmd('SaveSession')
    end,
})
