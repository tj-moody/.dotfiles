-- Fix filetype.vim format options issue{{{
vim.api.nvim_create_autocmd({ 'Filetype' }, {
    pattern = { '*' },
    group = vim.api.nvim_create_augroup('Filetype Options', {}),
    callback = function(_)
        vim.cmd('set formatoptions-=cro')
    end,
})
-- }}}
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
end                                                          -- }}}
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
end                                                        -- }}}
local function line_fold_extmark(buf, ns_id, linenr, line) -- {{{
    local pattern = ''
    if line:sub(-1) == '{' then
        pattern = '{+'
    elseif line:sub(-1) == '}' then
        pattern = '}+'
    else
        return
    end

    if pattern == '' then return end
    local fold_pos = nil
    local last_match = nil

    local commentstr = vim.bo.commentstring:sub(1, -3)

    for match in line:gmatch(pattern) do
        if #match >= 3 then
            last_match = match
            fold_pos = line:find(match, fold_pos, true)
        end
        -- Only accept multiples of 3 curly braces
        if #match % 3 ~= 0 and fold_pos then
            fold_pos = fold_pos + #match % 3
        end
    end

    -- Don't hide multilpes of standalone fold pattern `{{{}}}`
    if pattern == '}+' and last_match then
        if line:sub(-2 * #last_match, - #last_match - 1)
            == string.rep('{', #last_match) then
            return
        end
    end

    if not fold_pos or vim.fn.foldclosed(linenr) ~= -1 then
        return
    end

    -- Include comment directly proceeding fold marker in extmark
    local preceding_comment = false

    local comment_pos = fold_pos - #commentstr + 1
    local comment_match = line:sub(comment_pos, fold_pos - 1)
    if comment_match == commentstr:sub(1, -2) then
        fold_pos = comment_pos
        preceding_comment = true
    end

    -- Account for space between commentstring and marker, ie `-- {{{`}}}
    if not preceding_comment then
        comment_pos = comment_pos - 1
        comment_match = line:sub(comment_pos, fold_pos - 1)
        if comment_match == commentstr then
            fold_pos = comment_pos
            preceding_comment = true
        end
    end

    -- Account for inlay text in column
    local col = fold_pos - 1 + (vim.fn.virtcol({ linenr, #line }) - #line)

    if preceding_comment then
        local char_before_comment = line:sub(comment_pos - 1, comment_pos - 1)
        if char_before_comment == ' ' then
            col = col - 1
        end
    end

    vim.api.nvim_buf_set_extmark(
        buf, ns_id, linenr - 1, 0, {
            virt_text = { {
                -- ' …' .. string.rep(' ', #line - fold_pos),
                '  ' .. string.rep(' ', #line - fold_pos),
                'Folded',
            } },
            virt_text_win_col = col,
        })
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
        if not vim.g.hide_folds then return end
        for linenr, line in ipairs(
            vim.api.nvim_buf_get_lines(opts.buf, 0, -1, true)
        ) do
            line_fold_extmark(opts.buf, ns_id, linenr, line)
            line_escaped_extmark(opts.buf, ns_id, linenr, line)
            local has_parser = require "nvim-treesitter.parsers".has_parser()
            -- Treesitter parser does not exist on startup
            if opts.event ~= "BufEnter" and has_parser then
                line_multiline_if_extmark(opts.buf, ns_id, linenr)
            end
        end
    end
}) -- }}}
