---- Use nvim-tree when opening a directory on launch
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = { "*" },
    group = vim.api.nvim_create_augroup("NvimTree Launch", {}),
    callback = function(opts)
        local directory = vim.fn.isdirectory(opts.file) == 1
        if not directory then
            return
        end

        vim.cmd.cd(opts.file)
        safe_require("plugins.nvim-tree")
        safe_require("nvim-tree.api").tree.open()
        vim.cmd("only")
    end,
})

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

-- ---- Automatically enable inlay hints
-- vim.api.nvim_create_autocmd({ 'LspAttach' }, {
--     pattern = { '*' },
--     group = vim.api.nvim_create_augroup('Inlay Hints', {}),
--     callback = function(opts)
--         if not (opts.data and opts.data.client_id) then
--             return
--         end

--         local bufnr = opts.buf
--         local client = vim.lsp.get_client_by_id(opts.data.client_id)

--         if client.name == 'lua_ls' then
--             return
--         end

--         if client.server_capabilities.inlayHintProvider then
--             vim.lsp.inlay_hint(bufnr, true)
--         end
--     end,
-- })

---- Format makefile whitespace properly
vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = vim.api.nvim_create_augroup("Filetype Options", {}),
    pattern = { "make" },
    callback = function(_)
        vim.bo.expandtab = false
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 0
    end,
})

---- Auto-restore session
vim.api.nvim_create_autocmd({ "VimLeave" }, {
    pattern = { "*" },
    group = vim.api.nvim_create_augroup("Auto-Session", {}),
    callback = function(opts)
        if vim.g.in_pager_mode then
            return
        end
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = opts.buf })
        if filetype == "alpha" then
            return
        end

        for _, buf in ipairs(vim.fn.tabpagebuflist()) do
            if vim.fn.bufname(buf):sub(1, 7) == "term://" then
                vim.cmd("bd! " .. buf)
            end
            if vim.bo[buf].filetype == "NvimTree" then
                vim.cmd("bd! " .. buf)
            end
            if vim.bo[buf].filetype == "toggleterm" then
                vim.cmd("bd! " .. buf)
            end
        end
        vim.cmd("SessionSave")
    end,
})

---- Per-line Extmarks

---Create an extmark of '󰘍' before the contents of a line
---@param buf integer Buffer number
---@param ns_id integer Namespace id
---@param linenr integer Line number (1-indexed)
---@param col? integer Column number (0-indexed)
local function set_linebreak_extmark(buf, ns_id, linenr, col) -- {{{
    if not col then
        col = vim.fn.indent(linenr)
    end
    if vim.fn.indent(linenr) < 2 then
        return
    end
    vim.api.nvim_buf_set_extmark(buf, ns_id, linenr - 1, 0, {
        virt_text = { { "󰘍", "LineNr" } },
        virt_text_win_col = col - 2,
    })
end -- }}}

---Create an extmark on a line or the line below
---if either are wrapped by a `\` character
---@param buf integer Buffer number
---@param ns_id integer Namespace id
---@param linenr integer Line number (1-indexed)
---@param line string Content of current line
local function line_escaped_extmark(buf, ns_id, linenr, line) -- {{{
    -- TODO: Possibly transition to syntax match conceal
    -- based system?
    local next_line_escaped = false
    local cur_line_escaped = false
    if line:sub(-1) == [[\]] then
        next_line_escaped = true
    end
    if line:find([[^%s*\]]) then
        cur_line_escaped = true
    end

    if cur_line_escaped then
        set_linebreak_extmark(buf, ns_id, linenr)
    end
    if next_line_escaped then
        set_linebreak_extmark(buf, ns_id, linenr + 1)
    end
end -- }}}

---Create an extmark on a line if part of a multiline if-statement
---@param buf integer Buffer number
---@param ns_id integer Namespace id
---@param linenr integer Line Number (1-indexed)
local function line_multiline_if_extmark(buf, ns_id, linenr) -- {{{
    -- FIX: Currently loops over every line of a multiline if,
    -- refactor to avoid this issue
    -- FIX: Additionally, looping continues until root unconditionally,
    -- address this issue if possible
    local node = vim.treesitter.get_node({
        bufnr = buf,
        pos = { linenr, vim.fn.indent(linenr) + 4 },
    })
    while node do
        if node:type() == "if_statement" or node:type() == "while_statement" then
            local conditions = node:field("condition")
            if conditions == {} then
                return
            end
            local condition = conditions[1]
            local range = { condition:range() }

            if range[1] == range[3] then
                return
            end

            -- while statements for some reason handle ranges differently?
            -- ranges begin 3 columns after they should
            -- TODO: File issue in lua ts parser?
            if node:type() == "while_statement" then
                range[2] = range[2] - 3
            end

            for nr = range[1] + 2, range[3] + 1 do
                set_linebreak_extmark(buf, ns_id, nr, range[2] + 1)
            end
        end
        node = node:parent()
    end
end -- }}}

-- Display '󰘍' before lines that are wrapped by a `\` character
-- Display '󰘍' before lines that are part of a multi-line if statement
-- TODO: Disable based on file length?
vim.api.nvim_create_autocmd({
    "InsertLeave",
    "BufEnter",
    "BufWritePre",
}, {
    -- https://github.com/neovim/neovim/pull/24279
    pattern = { "*" }, -- Shell filetypes?
    group = vim.api.nvim_create_augroup("custom_extmarks", {}),
    callback = function(opts)
        local ns_id = vim.api.nvim_create_namespace("tj_custom_extmarks")
        vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, 0, -1)

        local has_parser = false
        -- avoid loading treesitter on startup
        if opts.event ~= "BufEnter" then
            has_parser = safe_require("nvim-treesitter.parsers").has_parser()
        end

        for linenr, line in ipairs(vim.api.nvim_buf_get_lines(opts.buf, 0, -1, true)) do
            line_escaped_extmark(opts.buf, ns_id, linenr, line)
            -- Treesitter parser does not exist on startup
            if has_parser then
                line_multiline_if_extmark(opts.buf, ns_id, linenr)
            end
        end
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*" },
    callback = function()
        if vim.fn.expand("%:p"):sub(1, 7) == "term://" then ---@diagnostic disable-line
            vim.cmd("setlocal nonumber norelativenumber nobuflisted")
            local opts = { noremap = true, silent = true, buffer = 0 }
            vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
            vim.cmd("norm! i")
        end
    end,
})

vim.api.nvim_create_autocmd("CmdWinEnter", {
    pattern = { "*" },
    callback = function(opts)
        vim.keymap.set("n", "<CR>", "<C-C><CR>", { noremap = true, silent = true, buffer = opts.buf })
    end,
})

vim.api.nvim_create_autocmd("CmdlineChanged", {
    callback = function()
        local cmdline = vim.fn.getcmdline()
        local cmdtype = vim.fn.getcmdtype()

        -- Only trigger for : commands
        if cmdtype == ":" then
            local scheme = cmdline:match("^colorscheme%s+(%S+)$")
            if scheme and scheme ~= "" then
                pcall(vim.cmd.colorscheme, scheme)
                vim.cmd.redraw()
            end
        end
    end,
})
