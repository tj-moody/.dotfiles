-- fix filetype.vim format options issue
vim.api.nvim_create_augroup('Filetype Options', {})
vim.api.nvim_create_autocmd({ 'Filetype' }, {
    pattern = { '*' },
    group = 'Filetype Options',
    callback = function(_)
        vim.cmd('set formatoptions-=cro')
    end,
})

-- Use nvim-tree when opening a directory on launch
vim.api.nvim_create_augroup('NvimTree Launch', {})
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    pattern = { '*' },
    group = 'NvimTree Launch',
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

-- start lsp after loading file to lazyload lsp plugins
vim.api.nvim_create_augroup('LSP Auto Start', {})
vim.api.nvim_create_autocmd({ 'InsertEnter', }, {
    pattern = { '*' },
    group = 'LSP Auto Start',
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

--- https://github.com/2KAbhishek/nvim2k/blob/main/lua/nvim2k/autocmd.lua
-- Strip trailing spaces before write
vim.api.nvim_create_augroup('Format On Save', {})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    group = 'Format On Save',
    callback = function(_)
        local save = vim.fn.winsaveview()
        vim.cmd([[ %s/\s\+$//e ]])
        vim.fn.winrestview(save)
    end,
})

-- Enable spellcheck on gitcommit and markdown
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = 'Filetype Options',
    pattern = { 'gitcommit', 'markdown', '*.txt' },
    callback = function(_)
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Automatically enable inlay hints
vim.api.nvim_create_augroup('Inlay Hints', {})
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    pattern = { '*' },
    group = 'Inlay Hints',
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

-- Format makefile whitespace properly
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    group = 'Filetype Options',
    pattern = { 'make' },
    callback = function(_)
        vim.bo.expandtab = false
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 0
    end,
})

vim.api.nvim_create_augroup('Auto-Session', {})
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
    pattern = { '*' },
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

-- Display '󰘍' before lines that are wrapped by a `\` character
-- Pretty cool feature!
-- TODO: Optimize to only check modified lines?
local function make_linebreak_extmark(buf, ns_id, linenr, line_offset, col)
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
end
local function check_escaped_line(buf, ns_id, linenr, line)
    local next_line_escaped = false
    local cur_line_escaped = false
    if line:sub(-1) == [[\]] then next_line_escaped = true end
    if line:find([[^%s*\]]) then cur_line_escaped = true end

    if cur_line_escaped then
        make_linebreak_extmark(buf, ns_id, linenr, 0)
    end
    if next_line_escaped then
        make_linebreak_extmark(buf, ns_id, linenr, 1)
    end
end
vim.api.nvim_create_augroup('Line Break Extmarks', {})
vim.api.nvim_create_autocmd({
    'TextChanged',
    'TextChangedI',
    'TextChangedP',
    'BufEnter',
}, {
    pattern = { '*' },
    callback = function(opts)
        local ns_id = vim.api.nvim_create_namespace('Line Break Extmarks')
        vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, 0, -1)
        for linenr, line in ipairs(
            vim.api.nvim_buf_get_lines(opts.buf, 0, -1, true)
        ) do
            check_escaped_line(opts.buf, ns_id, linenr, line)
        end
    end
})

local function check_multiline_if(buf, ns_id, lang)
    local parser = vim.treesitter.get_parser(buf, lang)
    local root = parser:parse()[1]:root()
    local multiline_if = vim.treesitter.query.parse(
        "lua",
        [[
            (if_statement
              condition: (expression) @cond
              (#contains? @cond "\n" )
              (#offset! @cond 0 1 0 1)
            )
        ]]
    )
    for id, node in multiline_if:iter_captures(root, buf, 0, -1) do
        local name = multiline_if.captures[id]
        if name == "cond" then
            local range = { node:range() }
            for linenr = range[1] + 2, range[3] + 1 do
                make_linebreak_extmark(buf, ns_id, linenr, 0, range[2] + 1)
            end
        end
    end
end
vim.api.nvim_create_augroup('Multiline If Extmarks', {})
vim.api.nvim_create_autocmd({
    'TextChanged',
    'TextChangedI',
    'TextChangedP',
    'BufEnter',
}, {
    pattern = { '*' },
    callback = function(opts)
        local ns_id = vim.api.nvim_create_namespace('Line Break Extmarks')
        vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, 0, -1)
        local filetype = vim.bo[opts.buf].filetype
        -- TODO: Migrate to pattern, find better solution
        local allowed_languages = {
            "lua",
            "python",
        }
        for _, v in ipairs(allowed_languages) do
            if filetype == v then
                check_multiline_if(opts.buf, ns_id, filetype)
            end
        end
    end
})

-- Hide fold markers
-- Note: Broken by inlay hints
local function fold_extmarks(ns_id, buf, linenr, line)
    local pattern = ''
    if line:sub(-1) == '{' then
        pattern = '{+'
    elseif line:sub(-1) == '}' then
        pattern = '}+'
    else
        return
    end

    if pattern == '' then return end
    local last_position = nil
    local last_match = nil

    local commentstring = vim.bo.commentstring:sub(1, -3)

    for match in line:gmatch(pattern) do
        if #match >= 3 then
            last_match = match
            last_position = line:find(match, last_position, true)
        end
        if #match % 3 ~= 0 and last_position then
            last_position = last_position + #match % 3
        end
    end
    if pattern == '}+' and last_match then
        if line:sub(-2 * #last_match, - #last_match - 1)
            == string.rep('{', #last_match) then
            return
        end
    end
    if not last_position
        or vim.fn.foldclosed(linenr) ~= -1 then
        return
    end
    if line:sub(
            last_position - #commentstring,
            last_position - 1
        ) == commentstring then
        last_position = last_position - #commentstring
    end
    vim.api.nvim_buf_set_extmark(
        buf, ns_id, linenr - 1, 0, {
            virt_text = { {
                ' …' .. string.rep(' ', #line - last_position - 1),
                'LineNr',
            } },
            virt_text_win_col = last_position - 1
                + (vim.fn.virtcol({ linenr, #line }) - #line),
        })
end
vim.api.nvim_create_augroup('Fold Hide Extmarks', {})
vim.api.nvim_create_autocmd({
    'InsertLeave',
    'TextChanged',
    'TextChangedI',
    'TextChangedP',
    'BufEnter',
}, {
    -- Add `FoldChanged` event when (if) implemented
    -- https://github.com/neovim/neovim/pull/24279
    pattern = { '*', }, -- Shell filetypes?
    callback = function(opts)
        local ns_id = vim.api.nvim_create_namespace('Fold Hide Extmarks')
        vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, 0, -1)
        for linenr, line in ipairs(
            vim.api.nvim_buf_get_lines(opts.buf, 0, -1, true)
        ) do
            fold_extmarks(ns_id, opts.buf, linenr, line)
        end
    end
})
