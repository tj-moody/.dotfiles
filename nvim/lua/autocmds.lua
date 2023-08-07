-- fix filetype.vim format options issue
vim.api.nvim_create_augroup("Filetype Options", {})
vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = { '*' },
    group = "Filetype Options",
    callback = function(_)
        vim.cmd("set formatoptions-=cro")
    end,
})

-- Use nvim-tree when opening a directory on launch
vim.api.nvim_create_augroup("NvimTree Launch", {})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = { '*' },
    group = "NvimTree Launch",
    callback = function(args)
        local directory = vim.fn.isdirectory(args.file) == 1
        if not directory then
            return
        end

        vim.cmd.cd(args.file)
        require("nvim-tree.api").tree.open()
        vim.cmd('only')
    end
})

-- start lsp after loading file to lazyload lsp plugins
vim.api.nvim_create_augroup("LSP Auto Start", {})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'CursorHold' }, {
    pattern = { '*' },
    group = "LSP Auto Start",
    callback = function(opts)
        vim.cmd('LspStart')
    end,
})

--- https://github.com/2KAbhishek/nvim2k/blob/main/lua/nvim2k/autocmd.lua
-- Strip trailing spaces before write
vim.api.nvim_create_augroup("Format On Save", {})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    group = "Format On Save",
    callback = function()
        vim.cmd([[ %s/\s\+$//e ]])
    end,
})

-- Enable spellcheck on gitcommit and markdown
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = "Filetype Options",
    pattern = { 'gitcommit', 'markdown', '*.txt' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Automatically enable inlay hints
vim.api.nvim_create_augroup("Inlay Hints", {})
vim.api.nvim_create_autocmd({ "LspAttach" }, {
    pattern = { '*' },
    group = "Inlay Hints",
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.name == "lua_ls" then
            return
        end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint(bufnr, true)
        end
    end,
})

-- Format makefile whitespace properly
vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = "Filetype Options",
    pattern = { 'make' },
    callback = function(_)
        vim.bo.expandtab = false
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 0
    end,
})
-- vim.cmd [[autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0]]

vim.api.nvim_create_augroup("Auto-Session", {})
vim.api.nvim_create_autocmd({ "VimLeave" }, {
    pattern = { '*' },
    callback = function(args)
        if vim.g.in_pager_mode then
            return
        end
        if vim.api.nvim_get_option_value("filetype", { buf = args.buf }) == "alpha" then
            return
        end
        vim.cmd("SessionSave")
    end,

})
