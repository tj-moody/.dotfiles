-- fix filetype.vim format options issue
vim.api.nvim_create_autocmd('Filetype', {
    callback = function(opts)
        vim.cmd("set formatoptions-=cro")
    end,
})

-- Use nvim-tree when opening a directory on launch
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

-- to optimize startup time with lazy event
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

--- https://github.com/2KAbhishek/nvim2k/blob/main/lua/nvim2k/autocmd.lua
-- Strip trailing spaces before write
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    callback = function()
        vim.cmd([[ %s/\s\+$//e ]])
    end,
})

-- Enable spellcheck on gitcommit and markdown
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'gitcommit', 'markdown', '*.txt' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
---
