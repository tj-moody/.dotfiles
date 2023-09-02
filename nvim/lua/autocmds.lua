-- Use nvim-tree when opening a directory on launch{{{
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup('NvimTree Launch', {}),
    callback = function(opts)
        local directory = vim.fn.isdirectory(opts.file) == 1
        if not directory then
            return
        end

        vim.cmd.cd(opts.file)
        require('nvim-tree.api').tree.open()
        vim.cmd('only')
    end
})
-- }}}
-- Start lsp after loading file to lazyload lsp plugins{{{
vim.api.nvim_create_autocmd({ 'InsertEnter', }, {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup('LSP Auto Start', {}),
    callback = function(_)
        if vim.bo.filetype == 'term' then
            return
        end
        if vim.bo.filetype == 'toggleterm' then
            return
        end
        if vim.bo.filetype == 'projterm' then
            return
        end
        vim.cmd('LspStart')
    end,
})
-- }}}
-- Strip trailing spaces before write{{{
-- https://github.com/2KAbhishek/nvim2k/blob/main/lua/nvim2k/autocmd.lua
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup('Format On Save', {}),
    callback = function(_)
        local save = vim.fn.winsaveview()
        vim.cmd([[ %s/\s\+$//e ]])
        vim.fn.winrestview(save)
    end,
})
-- }}}
-- Enable spellcheck on gitcommit and markdown{{{
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('Filetype Options', {}),
    pattern = { 'gitcommit', 'markdown', '*.txt' },
    callback = function(_)
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
-- }}}
-- Automatically enable inlay hints{{{
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup('Inlay Hints', {}),
    callback = function(opts)
        if not (opts.data and opts.data.client_id) then
            return
        end

        local bufnr = opts.buf
        local client = vim.lsp.get_client_by_id(opts.data.client_id)

        if client.name == 'lua_ls' then
            return
        end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint(bufnr, true)
        end
    end,
})
-- }}}
-- Format makefile whitespace properly{{{
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    group = vim.api.nvim_create_augroup('Filetype Options', {}),
    pattern = { 'make' },
    callback = function(_)
        vim.bo.expandtab = false
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 0
    end,
})
-- }}}
-- Auto-restore session{{{
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup('Auto-Session', {}),
    callback = function(opts)
        if vim.g.in_pager_mode then
            return
        end
        local filetype = vim.api.nvim_get_option_value(
            'filetype', { buf = opts.buf })
        if filetype == 'alpha' then
            return
        end
        vim.cmd('SessionSave')
    end,

})
-- }}}
-- Per-line Extmarks{{{
local function set_linebreak_extmark(buf, ns_id, linenr, line_offset, col) -- {{{
    if not line_offset then line_offset = 0 end
    if not col then col = vim.fn.indent(linenr + line_offset) end

    if vim.fn.indent(linenr + line_offset) < 2 then return end
    vim.api.nvim_buf_set_extmark(
        buf, ns_id,
        linenr - 1 + line_offset,
        0,
        {
            virt_text = { { '󰘍', 'LineNr' } },
            virt_text_win_col = col - 2,
        })
end                                                           -- }}}
local function line_escaped_extmark(buf, ns_id, linenr, line) -- {{{
    -- TODO: Possibly transition to syntax match conceal
    -- based system?
    local next_line_escaped = false
    local cur_line_escaped = false
    if line:sub(-1) == [[\]] then next_line_escaped = true end
    if line:find([[^%s*\]]) then cur_line_escaped = true end

    if cur_line_escaped then
        set_linebreak_extmark(buf, ns_id, linenr, 0)
    end
    if next_line_escaped then
        set_linebreak_extmark(buf, ns_id, linenr, 1)
    end
end -- }}}
-- FIX: Currently loops over every line of a multiline if,
-- refactor to avoid this issue
local function line_multiline_if_extmark(buf, ns_id, linenr) -- {{{
    local node = vim.treesitter.get_node({
        bufnr = buf,
        pos = { linenr, vim.fn.indent(linenr) + 4 }
    })
    while node do
        if node:type() == 'if_statement' then
            local conditions = node:field('condition')
            if conditions == {} then return end
            local condition = conditions[1]
            local range = { condition:range() }
            for nr = range[1] + 2, range[3] + 1 do
                set_linebreak_extmark(buf, ns_id, nr, 0, range[2] + 1)
            end
        end
        node = node:parent()
    end
end -- }}}
-- Display '󰘍' before lines that are wrapped by a `\` character
-- Display '󰘍' before lines that are part of a multi-line if statement
-- Hide fold markers
-- TODO: Disable based on file length?
vim.api.nvim_create_autocmd({
    'InsertLeave',
    'TextChanged',
    'TextChangedI',
    'TextChangedP',
    'BufEnter',
    'BufWritePre',
}, {
    -- Add `FoldChanged` event when (if) implemented
    -- https://github.com/neovim/neovim/pull/24279
    pattern = { '*', }, -- Shell filetypes?
    group = vim.api.nvim_create_augroup('Fold Hide Extmarks', {}),
    callback = function(opts)
        local ns_id = vim.api.nvim_create_namespace('Custom Extmarks')
        vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, 0, -1)
            local has_parser = false
            if opts.event ~= "BufEnter" then
                has_parser = require('nvim-treesitter.parsers').has_parser()
            end
        for linenr, line in ipairs(
            vim.api.nvim_buf_get_lines(opts.buf, 0, -1, true)
        ) do
            line_escaped_extmark(opts.buf, ns_id, linenr, line)
            -- Treesitter parser does not exist on startup
            if has_parser then
                line_multiline_if_extmark(opts.buf, ns_id, linenr)
            end
        end
    end
}) -- }}}
