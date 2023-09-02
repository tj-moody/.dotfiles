vim.g.mapleader = ","

--- FUNCTIONS{{{

local fn = vim.fn
local api = vim.api

---An abbreviation of *vim.keymap.set*(`mode`, `lhs`, `rhs`, opts) with
---```lua
---    opts = { noremap = true, silent = true }
---```
---@param m string | table[string]
---@param l string
---@param r string | function
local function map(m, l, r)
    vim.keymap.set(m, l, r, { noremap = true, silent = true })
end

---An abbreviation of *vim.keymap.set*(`mode`, `lhs`, `rhs`, `opts`)
---@param m string | table[string]
---@param l string
---@param r string | function
---@param opts table | nil
local function m_o(m, l, r, opts)
    vim.keymap.set(m, l, r, opts)
end
-- }}}
--- VANILLA{{{
----- Remapped Defaults{{{
map('n', '\\', ',')

m_o('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
m_o('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map('n', 'p', ']p')
map('v', 'p', '"0p') -- '"0pgv'

map({ 'n', 'v' }, 'x', '"_x')
map({ 'n', 'v' }, 'd', '"_d')
map({ 'n', 'v' }, 'c', '"_c')
map('n', 'S', '"_S')

map('n', 'Y', 'yy')
map('n', 'D', '"_dd')
map('n', 'X', 'dd')

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('i', '<esc>', '<esc>`^')
-- }}}
----- Basics{{{

map('n', '<leader>.', '<CMD>vsp<CR><CMD>Telescope smart_open<CR>')

map('n', '<leader>w', '<CMD>silent update<CR>')
map('n', '<leader><leader>x', '<CMD>silent write<CR><CMD>source <CR>')

map('n', '<leader>q', '<CMD>q<CR>')
map('n', '<ESC>', "<CMD>noh<CR><CMD>ColorizerReloadAllBuffers<CR><CMD>echo ''<CR>")

map('v', 'K', ":m '<-2<CR>gv=gv")
map('v', 'J', ":m '>+1<CR>gv=gv")

map('n', '<CR>', 'mz<CMD>a<CR><CR>.<CR>`z')
map('n', '<S-CR>', 'mz<CMD>i<CR><CR>.<CR>`z')

map('n', 'J', 'mzJ`z')

map('n', 's', '<Plug>Ysurround')
map('n', 'ss', '<Plug>Yssurround')
map('v', 's', '<Plug>VSurround')
-- ^^^ charwise in visual mode, linewise in visual line mode

map('n', 'sl', '<CMD>vsp<CR>')
map('n', 'sj', '<CMD>sp<CR>')
map('n', 'se', '<c-w>=')
map('n', 'sr', require('smart-splits').start_resize_mode)

map('v', 'V', 'j')

map('n', 'gV', '`[v`]')

map('n', '<TAB>', '<CMD>tabnext<CR>')
map('n', '<S-TAB>', '<CMD>tabprevious<CR>')

-- Backspace helper values{{{
local escape_code = api.nvim_replace_termcodes(
    '<Esc>',
    false, false, true
)
local backspace_code = api.nvim_replace_termcodes(
    '<BS>',
    false, false, true
)
local function viml_backspace()
    -- expression from a deleted reddit user
    vim.cmd([[
        let g:exprvalue =
        \ (&indentexpr isnot '' ? &indentkeys : &cinkeys) =~? '!\^F' &&
        \ &backspace =~? '.*eol\&.*start\&.*indent\&' &&
        \ !search('\S','nbW',line('.')) ? (col('.') != 1 ? "\<C-U>" : "") .
        \ "\<bs>" . (getline(line('.')-1) =~ '\S' ? "" : "\<C-F>") : "\<bs>"
        ]])
    return vim.g.exprvalue
end
local indent_unsupported_filetypes = {
    'asm'
}
local indent_based_filetypes = {
    'python'
}                -- }}}
m_o('i', '<BS>', -- {{{
    function()
        local unsupported_filetype = false
        for _, v in ipairs(indent_unsupported_filetypes) do
            if vim.bo.filetype == v then
                unsupported_filetype = true
            end
        end
        if unsupported_filetype then
            return require('nvim-autopairs').autopairs_bs()
        end

        local line, col = unpack(api.nvim_win_get_cursor(0))
        local before_cursor_is_whitespace = api.nvim_get_current_line()
            :sub(0, col)
            :match('^%s*$')

        if not before_cursor_is_whitespace then
            return require('nvim-autopairs').autopairs_bs()
        end
        if line == 1 then
            return escape_code .. '==^i'
        end

        local indent_based_filetype = false
        for _, v in ipairs(indent_based_filetypes) do
            if vim.bo.filetype == v then
                indent_based_filetype = true
            end
        end
        local correct_indent = require('nvim-treesitter.indent')
            .get_indent(line) / vim.bo.tabstop
        local current_indent = fn.indent(line) / vim.bo.tabstop
        local previous_line_is_whitespace = api.nvim_buf_get_lines(
            0, line - 2, line - 1, false
        )[1]:match('^%s*$')
        if current_indent == correct_indent then
            if previous_line_is_whitespace and not indent_based_filetype then
                return viml_backspace()
            end
            return backspace_code
        elseif current_indent > correct_indent then
            return string.rep(backspace_code, current_indent - correct_indent)
        end
        return require('nvim-autopairs').autopairs_bs()
    end,
    { expr = true, noremap = true, replace_keycodes = false, }
)
map('i', '<S-BS>', '<BS>') -- }}}

---Adapted from https://vi.stackexchange.com/a/12870
---Traverse to indent >= or > current indent
---@param direction integer 1 - forwards | -1 - backwards
---@param equal boolean include lines equal to current indent in search?
local function indent_traverse(direction, equal) -- {{{
    return function()
        -- Get the current cursor position
        local current_line, column = unpack(api.nvim_win_get_cursor(0))
        local match_line = current_line
        local match_indent = false
        local match = false

        local buf_length = api.nvim_buf_line_count(0)

        -- Look for a line of appropriate indent
        -- level without going out of the buffer
        while (not match) and (match_line ~= buf_length) do
            match_line = match_line + direction
            local match_line_str = api.nvim_buf_get_lines(0, match_line - 1, match_line, false)[1]
            local match_line_is_whitespace = match_line_str:match('^%s*$')

            if equal then
                match_indent = fn.indent(match_line) <= fn.indent(current_line)
            else
                match_indent = fn.indent(match_line) < fn.indent(current_line)
            end
            match = match_indent and not match_line_is_whitespace
        end

        -- If a line is found go to line
        if match or match_line == buf_length then
            fn.cursor({ match_line, column + 1 })
        end
    end
end                                                 -- }}}
map({ 'n', 'v' }, "gj", indent_traverse(1, true))   -- next equal indent
map({ 'n', 'v' }, 'gk', indent_traverse(-1, true))  -- previous equal indent

map({ 'n', 'v' }, 'gJ', indent_traverse(1, false))  -- next equal indent
map({ 'n', 'v' }, 'gK', indent_traverse(-1, false)) -- previous equal indent

map('n', '<leader>O',                               -- {{{
    -- Delete all other buffers
    function()
        if vim.bo.filetype == 'NvimTree' then
            vim.cmd('only')
        else
            local invisible_buffers = {}

            for buffer = 1, fn.bufnr('$') do
                if fn.buflisted(buffer) == 1 then
                    invisible_buffers[tostring(buffer)] = true
                    for _, v in ipairs(fn.tabpagebuflist()) do
                        if buffer == v then
                            invisible_buffers[tostring(buffer)] = false
                        end
                    end
                end
            end
            for buffer, invisible in pairs(invisible_buffers) do
                if invisible then vim.cmd.bdelete(tonumber(buffer)) end
            end
            vim.cmd [[redrawtabline]]
        end
    end
) -- }}}
map('n', '<leader>o', '<CMD>silent only<CR>')

map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')

map('v', '<', '<gv4h')
map('v', '>', '>gv4l')

map('n', '<leader>cr',
    function()
        vim.cmd [[
            let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
            for r in regs
            call setreg(r, [])
            endfor
        ]]
        print('Cleared registers')
    end
)

m_o('v', [["]], [[<Plug>VSurround"]], { noremap = false, })
m_o('v', [[']], [[<Plug>VSurround']], { noremap = false, })
m_o('v', [[(]], [[<Plug>VSurround)]], { noremap = false, })
m_o('v', [[{]], [[<Plug>VSurround)]], { noremap = false, })
vim.cmd('unmap [%')
m_o('v', '[', '<Plug>VSurround]', { noremap = false, })

map('n', 'r<CR>',
    function()
        local node = vim.treesitter.get_node():type()
        vim.cmd [[execute "norm! r\<CR>"]]
        if node == 'comment_content' or node == 'comment' then
            vim.cmd([[norm! ^i]] .. vim.bo.commentstring:sub(1, -3))
        end
    end
)

-- Restart nvim
map('n', '<leader>R', '<CMD>wa<CR><CMD>SessionSave<CR><CMD>cq<CR>')

map('i', '<ScrollWheelLeft>', '')
map('i', '<ScrollWheelRight>', '')
map('n', '<ScrollWheelLeft>', '')
map('n', '<ScrollWheelRight>', '')
map('v', '<ScrollWheelLeft>', '')
map('v', '<ScrollWheelRight>', '')

-- }}}}}}
--- GROUPS{{{
----- NvimTree{{{

map('n', 't',
    -- Toggle NvimTree
    function()
        if vim.g.nvimtreefloat == true then
            safe_require('config.nvim-tree').nvim_tree_setup()
            return
        end
        if vim.bo.filetype == 'NvimTree' then
            vim.cmd('NvimTreeClose')
        else
            vim.cmd('NvimTreeClose')
            vim.cmd('NvimTreeOpen')
        end
        safe_require('colorscheme').setup('nvim_tree')
    end
)

map('n', 'TT',
    -- Toggle NvimTree float
    function()
        if vim.g.nvimtreefloat == true then
            vim.g.nvimtreefloat = false
            vim.cmd('NvimTreeClose')
            safe_require('config.nvim-tree').nvim_tree_setup()
        else
            safe_require('config.nvim-tree').nvim_tree_float_setup()
            vim.cmd('NvimTreeClose')
            vim.cmd('NvimTreeOpen')
        end
    end
)
-- }}}
----- Telescope{{{
map('n', '<leader>ff', '<CMD>Telescope smart_open<CR>')
map('n', '<leader>fh', '<CMD>Telescope highlights<CR>')
map('n', '<leader>fg', '<CMD>Telescope live_grep<CR>')
map('n', '<leader>fk', '<CMD>Telescope keymaps<CR>')
-- }}}
----- Bufferline{{{
map('n', 'H', '<CMD>BufferLineCyclePrev<CR>')
map('n', 'L', '<CMD>BufferLineCycleNext<CR>')
map('n', 'Tc', '<CMD>BufferLinePickClose<CR>')
map('n', 'Tp', '<CMD>BufferLinePick<CR>')
-- }}}
----- Tabs{{{
map('n', 'T.', '<CMD>tabe %<CR><CMD>Telescope smart_open<CR>')
map('n', 'Tn', '<CMD>tabe %<CR>')
map('n', 'TL', '<CMD>tabnext<CR>')
map('n', 'TH', '<CMD>tabprevious<CR>')
map('n', 'To', '<CMD>tabonly<CR>')
map('n', 'Tq', '<CMD>tabclose<CR>')
-- }}}
----- Lazy{{{
map('n', '<leader>lz', '<CMD>Lazy<CR>')
-- }}}
----- Toggleterm{{{

-- Set keymaps to align with normal navigation in terminal buffers
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- m('n', '<C-T>', '<CMD>ToggleTerm size=40 direction=float<CR>')
map('n', '<leader>tf', '<CMD>ToggleTerm size=40 direction=float<CR>')
map('n', '<leader>tj', '<CMD>ToggleTerm size=20 direction=horizontal<CR>')
map('n', '<leader>tl', '<CMD>ToggleTerm size=60 direction=vertical<CR>')
map('t', '<C-T>', [[<C-\><C-n><CMD>q<CR>]])
-- }}}
----- Git{{{
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({
    cmd = 'lazygit',
    hidden = true,
    highlights = {
        NormalFloat = { guibg = '', guifg = '' },
        FloatBorder = { guibg = '' },
    }
})
-- m('n', '<leader>lg', '<CMD>ToggleTerm size=40 direction=float<CR>lazygit<CR>')
map('n', '<leader>lg',
    function()
        lazygit:toggle()
    end
)
map('n', '<leader>gd',
    function()
        if next(require('diffview.lib').views) == nil then
            vim.cmd('DiffviewOpen')
        else
            vim.cmd('DiffviewClose')
        end
    end
)
map('n', '<leader>gh',
    function()
        if next(require('diffview.lib').views) == nil then
            vim.cmd('DiffviewFileHistory')
        else
            vim.cmd('DiffviewClose')
        end
    end
)
map('n', '<leader>gj', '<CMD>Gitsigns next_hunk<CR>')
map('n', '<leader>gk', '<CMD>Gitsigns prev_hunk<CR>')
map('n', '<leader>gb', '<CMD>Gitsigns blame_line<CR>')
map('n', '<leader>gB', '<CMD>ToggleBlame virtual<CR>')
-- }}}
----- Splits{{{
map('n', '<C-h>', require('smart-splits').move_cursor_left)
map('n', '<C-j>', require('smart-splits').move_cursor_down)
map('n', '<C-k>', require('smart-splits').move_cursor_up)
map('n', '<C-l>', require('smart-splits').move_cursor_right)

map('n', '<Space>h', '<C-w>H')
map('n', '<Space>j', '<C-w>J')
map('n', '<Space>k', '<C-w>K')
map('n', '<Space>l', '<C-w>L')

map('n', 'sr', require('smart-splits').start_resize_mode)
-- }}}
----- TreeSJ{{{
map('n', '<c-s>', '<CMD>TSJToggle<CR>')
-- }}}
----- Alternate-Toggler{{{
map('n', '<leader>ta', '<CMD>ToggleAlternate<CR>')
-- }}}
----- Project{{{
map('n', '<leader>pr', '<CMD>ProjtasksRun<CR>')
map('n', '<leader>pp', '<CMD>ProjtasksToggle<CR>')
map('n', '<leader>pt', '<CMD>ProjtasksTest<CR>')
map('n', '<leader>pe', '<CMD>SnipRun<CR>')
map('v', '<leader>pe', '<CMD>SnipRun<CR>')
-- }}}
----- Comment{{{
map('n', '<leader>co', 'o_<esc><CMD>norm ,cc<cr>A<bs>')
map('n', '<leader>cO', 'O_<esc><CMD>norm ,cc<cr>A<bs>')
map('n', '<leader>cl',
    [[<CMD>execute "norm! A " . substitute(&commentstring, '%s', '', '')<CR>A]]
)                      -- https://vi.stackexchange.com/a/19163
map('n', '<leader>cs', -- {{{
    -- comment split below
    function()
        local line = api.nvim_get_current_line()

        local commentstring = vim.bo.commentstring:sub(1, -3)
        escaped_commentstring = string.gsub(commentstring, '-', '%%-')

        local _, count = string.gsub(
            line,
            escaped_commentstring,
            escaped_commentstring
        )
        if count == 0 then return end

        local last_position = nil
        for match in line:gmatch(escaped_commentstring) do
            last_position = line:find(match, last_position, true)
        end
        if not last_position then return end

        local linenr, _ = unpack(api.nvim_win_get_cursor(0))
        vim.cmd([[execute "norm! 0]] .. last_position - 1 .. [[l"]])
        if line:sub(-1) == ' ' then
            vim.cmd([[execute "norm! i\<BS>"]])
        end
        vim.cmd([[execute "norm! i\<CR>"]])
        if fn.indent(linenr) ~= 0 then
            vim.cmd([[norm! ]] .. string.rep('<<', fn.indent(linenr)))
            vim.cmd([[execute "norm! 0]]
                .. fn.indent(linenr)
                .. [[i \<ESC>"]]
            )
        end
        vim.cmd([[execute "norm! ^]]
            .. #commentstring
            .. [[l"]]
        )
    end
)                      -- }}}
map('n', '<leader>cS', -- {{{
    -- comment split above
    function()
        local line = api.nvim_get_current_line()

        local commentstring = vim.bo.commentstring:sub(1, -3)
        escaped_commentstring = string.gsub(commentstring, '-', '%%-')

        local _, count = string.gsub(
            line,
            escaped_commentstring,
            escaped_commentstring
        )
        if count == 0 then return end

        local last_position = nil
        for match in line:gmatch(escaped_commentstring) do
            last_position = line:find(match, last_position, true)
        end
        if not last_position then return end

        local linenr, _ = unpack(api.nvim_win_get_cursor(0))
        vim.cmd([[execute "norm! 0]] .. last_position - 1 .. [[l"]])
        if line:sub(-1) == ' ' then
            vim.cmd([[execute "norm! i\<BS>"]])
        end
        vim.cmd([[execute "norm! i\<CR>"]])
        vim.cmd([[execute "norm VK\<ESC>"]])
        if fn.indent(linenr + 1) ~= 0 then
            vim.cmd([[norm! ]] .. string.rep('<<', fn.indent(linenr)))
            vim.cmd([[execute "norm! 0]]
                .. fn.indent(linenr + 1)
                .. [[i \<ESC>"]]
            )
        end
        vim.cmd([[execute "norm! ^]] .. #commentstring .. [[l"]])
    end
)
-- TODO: Rewrite to not append commentstring if a comment already exitsts}}}
-- }}}
----- FOLDS{{{
-- }}}}}}
--- CONFIG{{{

map('n', 'C', '<nop>')
map('n', 'Cll',
    -- Toggle LSP Lines
    function()
        local d_conf = vim.diagnostic.config
        d_conf({
            virtual_text = not d_conf().virtual_text,
            virtual_lines = not d_conf().virtual_lines
        })
    end
)

map('n', 'Crn',
    -- Toggle relative number
    function()
        vim.cmd.set('relativenumber!')
    end
)

map('n', 'Cw',
    -- Toggle wrap
    function()
        vim.cmd.set('wrap!')
        print('Wrap: ' .. tostring(vim.o.wrap))
    end
)

map('n', 'Cba',
    -- Toggle Bufferline show all
    function()
        vim.g.bufferline_show_all = not vim.g.bufferline_show_all
        print('Bufferline Show All: ' .. tostring(vim.g.bufferline_show_all))
    end
)

map('n', 'Cih',
    -- Toggle inlay hints
    function()
        vim.lsp.inlay_hint(0, nil)
    end
)

map('n', 'Ccc',
    -- Toggle Colorcolumn
    function()
        vim.wo.colorcolumn = (vim.wo.colorcolumn == '80' and '0' or '80')
        print("Colorcolumn: "
            .. (vim.wo.colorcolumn == '80' and "true" or "false"))
    end
)

map('n', 'Cve',
    -- Toggle virtual edit
    function()
        if vim.o.virtualedit == 'all' then
            vim.o.virtualedit = 'block'
        else
            vim.o.virtualedit = 'all'
        end
        if vim.o.virtualedit == 'all' then
            print('Virtual Edit: true')
        else
            print('Virtual Edit: false')
        end
    end
)

map('n', 'Cgb',
    -- Toggle git blame
    function()
        vim.cmd('Gitsigns toggle_current_line_blame')
    end
)

map('n', 'Clv',
    -- Toggle detailed lualine
    function()
        vim.g.lualine_verbose = not vim.g.lualine_verbose
    end
)
map('n', 'Ct',
    -- Change theme
    function()
        vim.ui.select(safe_require('colorscheme').themes_list, {
                prompt = 'Choose theme:',
            },
            function(choice)
                if choice then
                    vim.g.tjtheme = choice
                    safe_require('colorscheme').reload()
                end
            end
        )
    end
)

map('n', 'Ccl',
    -- Toggle conceallevel
    function()
        if vim.o.conceallevel == 2 then
            vim.o.conceallevel = 0
        else
            vim.o.conceallevel = 2
        end
        print('Conceal: ' .. (vim.o.conceallevel == 2 and "true" or "false"))
    end
)

-- }}}
--- ABBREVIATIONS{{{
-- email
map('ia', '@@g', '92702993+tj-moody@users.noreply.github.com')

-- datetime
m_o('ia', 'dtfull', 'strftime("%c")', { expr = true })
m_o('ia', 'dtdate', 'strftime("%m/%d/%y")', { expr = true })
m_o('ia', 'dttime', 'strftime("%H:%M")', { expr = true }) -- }}}
