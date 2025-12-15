---- Strip trailing spaces before write
-- https://github.com/2KAbhishek/nvim2k/blob/main/lua/nvim2k/autocmd.lua
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    group = vim.api.nvim_create_augroup("Format On Save", {}),
    callback = function(_)
        local save = vim.fn.winsaveview()
        vim.cmd([[ %s/\s\+$//e ]])
        vim.fn.winrestview(save) ---@diagnostic disable-line
    end,
})

---- Auto-restore session
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    pattern = { "*" },
    group = vim.api.nvim_create_augroup("Auto-Session", {}),
    callback = function(_)
        if vim.g.in_pager_mode then
            return
        end

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local name = vim.fn.bufname(buf)
            local ft = vim.bo[buf].filetype

            if ft == "qf" or ft == "NvimTree" or ft == "projterm" or name:sub(1, 7) == "term://" then
                vim.cmd("silent! bd! " .. buf)
            end
        end

        if vim.g.no_save == nil or vim.g.no_save == false then
            vim.cmd("AutoSession save")
        end
    end,
})

-- Auto-load nvim-tree when opening a directory on startup
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local arg = vim.fn.argv(0)
        if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
            vim.cmd("silent! %bd")
            require("nvim-tree.api").tree.open()
            vim.cmd.only()
        end
    end,
})

-- <CR> to run cmdwin entry
vim.api.nvim_create_autocmd("CmdWinEnter", {
    pattern = { "*" },
    callback = function(opts)
        vim.keymap.set("n", "<CR>", "<C-C><CR>", { noremap = true, silent = true, buffer = opts.buf })
    end,
})
