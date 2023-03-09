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
