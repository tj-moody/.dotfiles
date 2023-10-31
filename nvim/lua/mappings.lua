local M = {}
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- FUNCTIONS{{{

local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

---An abbreviation of *vim.keymap.set*(`mode`, `lhs`, `rhs`, opts) with
---```lua
---    opts = { noremap = true, silent = true }
---```
---@param m string | table[string]
---@param l string
---@param r string | function
---@param desc string
local function map(m, l, r, desc)
    vim.keymap.set(m, l, r, { noremap = true, silent = true, desc = desc })
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

--- VANILLA
-- Remapped Defaults{{{

map('n', '\\', ',', "Undo Text Motion")

m_o('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Next Visual Line" })
m_o('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Prev Visual Line" })

map({ 'x', 'n' }, 'p', ']p', "Paste and Indent")
map('x', 'p', '"0p', "Paste")

map('n', 'X', '"_dd', "Delete Line")
map('x', 'x', '"_d', "Delete Character")
map({ 'n', 'x' }, 'c', '"_c', "Change")
map('n', 'S', '"_S', "Subsitute Line")

map('n', '<C-d>', '<C-d>zz', "Scroll Down")
map('n', '<C-u>', '<C-u>zz', "Scroll Up")

map('n', 'n', 'nzzzv', "Next Match")
map('n', 'N', 'Nzzzv', "Prev Match")

map('i', '<esc>', '<esc>`^', "Exit Insert Mode")

-- }}}
-- Basics{{{

map('n', '<leader>.', '<CMD>vsp<CR><CMD>Telescope smart_open<CR>', "Find File in Split")

map('n', '<leader>w', '<CMD>silent update<CR>', "Write")
map('n', '<leader><leader>x', '<CMD>silent write<CR><CMD>source <CR>', "Execute")

map('n', '<leader>q', '<CMD>q<CR>', "Quit")
map('n', '<ESC>', "<CMD>noh<CR><CMD>ColorizerReloadAllBuffers<CR><CMD>ColorizerAttachToBuffer<CR><CMD>echo ''<CR>",
    "Reset Screen")

map('x', 'K', ":m '<-2<CR>gv=gv", "Move Up")
map('x', 'J', ":m '>+1<CR>gv=gv", "Move Down")

map('n', '<CR>',
    function()
        local line_nr = vim.fn.line('.') ---@cast line_nr integer
        local line = vim.fn.getline(line_nr) ---@cast line string
        vim.api.nvim_buf_set_lines(0, line_nr - 1, line_nr, false, { line, '' })
    end,
    "Line Below"
)
map('n', '<S-CR>',
    function()
        local line_nr = vim.fn.line('.') ---@cast line_nr integer
        local line = vim.fn.getline(line_nr - 1) ---@cast line string
        vim.api.nvim_buf_set_lines(0, line_nr - 2, line_nr - 1, false, { line, '' })
    end,
    "Line Above"
)

map('n', 'J', 'mzJ`z', "Join")

map('n', 's', '<Plug>Ysurround', "Surround")
map('n', 'ss', '<Plug>Yssurround', "Surround Line")
map('x', 's', '<Plug>VSurround', "Surround")
-- ^^^ charwise in visual mode, linewise in visual line mode

map('n', 'sl', '<CMD>vsp<CR>', "Split Rigth")
map('n', 'sj', '<CMD>sp<CR>', "Split Down")
map('n', 'se', '<c-w>=', "Equalize Splits")
map('n', 'sr', require('smart-splits').start_resize_mode, "Resize Splits")

map('x', 'V', 'j', "Expand V-Line Selection")

map('n', 'gV', '`[v`]', "Highlight Prev Selection")

-- NOTE: Possibly unmap?
map('n', '<TAB>', '<CMD>tabnext<CR>', "Next Tab")
map('n', '<S-TAB>', '<CMD>tabprevious<CR>', "Prev Tab")

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
    cmd([[
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
    { expr = true, noremap = true, replace_keycodes = false, desc = "Smart Delete" }
)
map('i', '<S-BS>', '<BS>', "Delete") -- }}}

---Adapted from https://vi.stackexchange.com/a/12870
---Traverse to indent >= or > current indent
---@param direction integer 1 - forwards | -1 - backwards
---@param equal boolean include lines equal to current indent in search?
local function indent_traverse(direction, equal) -- {{{
    return function()
        local count = math.max(vim.v.count - 1, 0)
        for _ = 0, count do
            -- Get the current cursor position
            local current_line, column = unpack(api.nvim_win_get_cursor(0))
            local match_line = current_line
            local match_indent = false
            local match = false

            local buf_length = api.nvim_buf_line_count(0)

            -- Look for a line of appropriate indent
            -- level without going out of the buffer
            while (not match)
                and (match_line < buf_length)
                and (match_line > 1)
            do
                match_line = match_line + direction
                local match_line_str = api.nvim_buf_get_lines(0, match_line - 1, match_line, false)[1]
                -- local match_line_is_whitespace = match_line_str and match_line_str:match('^%s*$')
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
                if not equal then match_line = match_line - direction end
                fn.cursor({ match_line, column + 1 })
            end
        end
    end
end -- }}}
map({ 'n', 'x' }, "gj", indent_traverse(1, true), "Next Equal Indent")
map({ 'n', 'x' }, 'gk', indent_traverse(-1, true), "Prev Equal Indent")

map({ 'n', 'x' }, 'gJ', indent_traverse(1, false), "Last Equal Indent")
map({ 'n', 'x' }, 'gK', indent_traverse(-1, false), "First Equal Indent")

map('n', '<leader>O', -- {{{
    -- Delete all other buffers
    function()
        if vim.bo.filetype == 'NvimTree' then
            cmd('only')
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
                if invisible then cmd.bdelete(tonumber(buffer)) end
            end
            cmd [[redrawtabline]]
        end
    end,
    "Only Buffer"
) -- }}}
map('n', '<leader>o', '<CMD>silent only<CR>', "Only Window")

map('n', '<leader>y', '"+y', "Yank into Clipboard")
map('x', '<leader>y', '"+y', "Yank Into Clipboard")

map('x', '<', '<gv4h', "Shift Left")
map('x', '>', '>gv4l', "Shift Right")

map('n', '<leader>cr',
    function()
        cmd [[
            let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
            for r in regs
            call setreg(r, [])
            endfor
        ]]
        print('Cleared registers')
    end,
    "Clear Registers"
)

-- NOTE: Possibly unmap?
m_o('x', [["]], [[<Plug>VSurround"]], { noremap = false, desc = "Double Quote Surround" })
m_o('x', [[']], [[<Plug>VSurround']], { noremap = false, desc = "Single Quote Surround" })
m_o('x', [[(]], [[<Plug>VSurround)]], { noremap = false, desc = "Parentheses Surround" })
m_o('x', [[{]], [[<Plug>VSurround)]], { noremap = false, desc = "Braces Surround" })
-- cmd('unmap [%')
m_o('x', '[', '<Plug>VSurround]', { noremap = false, desc = "Brackets Surround" })

map('i', '<ScrollWheelLeft>', '', "")
map('i', '<ScrollWheelRight>', '', "")
map('n', '<ScrollWheelLeft>', '', "")
map('n', '<ScrollWheelRight>', '', "")
map('x', '<ScrollWheelLeft>', '', "")
map('x', '<ScrollWheelRight>', '', "")

m_o('i', ';',
    function()
        -- chars that can be afte the cursor to allow a semicolon, mostly closing delimiters
        local allowed_chars = {
            '\'',
            '"',
            ')',
            '}',
            '>',
        }
        local can_exit = true
        local _, col = unpack(api.nvim_win_get_cursor(0))
        local line = fn.getline('.') ---@cast line string
        for char in line:sub(col + 1, -1):gmatch('.') do
            (function()
                char_is_allowed = false
                for _, allowed_char in ipairs(allowed_chars) do
                    (function()
                        if char == allowed_char then
                            char_is_allowed = true; return
                        end
                    end)()
                end
                if not char_is_allowed then
                    can_exit = false; return
                end
            end)()
        end
        if can_exit then
            return '<ESC>A;'
        else
            return ';'
        end
    end,
    { remap = false, expr = true, desc = "Smart Semicolon" }
)
-- }}}

--- GROUPS
-- NvimTree{{{

map('n', 't',
    function()
        if vim.g.nvimtreefloat == true then
            safe_require('config.nvim-tree').nvim_tree_setup()
            return
        end
        if vim.bo.filetype == 'NvimTree' then
            cmd('NvimTreeClose')
        else
            cmd('NvimTreeClose')
            cmd('NvimTreeOpen')
        end
        safe_require('colorscheme').setup('nvim_tree')
    end,
    "Toggle NvimTree"
)

map('n', 'TT',
    function()
        if vim.g.nvimtreefloat == true then
            vim.g.nvimtreefloat = false
            cmd('NvimTreeClose')
            safe_require('config.nvim-tree').nvim_tree_setup()
        else
            safe_require('config.nvim-tree').nvim_tree_float_setup()
            cmd('NvimTreeClose')
            cmd('NvimTreeOpen')
        end
    end,
    "Toggle NvimTree Float"
)
-- }}}
-- Telescope{{{
map('n', '<leader>ff', '<CMD>Telescope smart_open<CR>', "Find File")
map('n', '<leader>fh', '<CMD>Telescope highlights<CR>', "Find Highlight")
map('n', '<leader>fg', '<CMD>Telescope live_grep<CR>', "Find Grep")
map('n', '<leader>fk', '<CMD>Telescope keymaps<CR>', "Find Keymap")
-- }}}
-- Bufferline{{{
map('n', 'H', '<CMD>BufferLineCyclePrev<CR>', "Previous Buffer")
map('n', 'L', '<CMD>BufferLineCycleNext<CR>', "Next Buffer")
map('n', '<leader>bc', '<CMD>BufferLinePickClose<CR>', "Close Buffer")
map('n', '<leader>bp', '<CMD>BufferLinePick<CR>', "Pick Buffer")
-- }}}
-- Tabs{{{
map('n', '<leader>t.', '<CMD>tabe %<CR><CMD>Telescope smart_open<CR>', "Find File in New Tab")
map('n', '<leader>tn', '<CMD>tabe %<CR>', "New Tab")
map('n', '<leader>tL', '<CMD>tabnext<CR>', "Next Tab")
map('n', '<leader>tH', '<CMD>tabprevious<CR>', "Prev Tab")
map('n', '<leader>to', '<CMD>tabonly<CR>', "Only Tab")
map('n', '<leader>tq', '<CMD>tabclose<CR>', "Quit Tab")
-- }}}
-- Lazy{{{
map('n', '<leader>lz', '<CMD>Lazy<CR>', "Lazy")
-- }}}
-- Git{{{
map('n', '<leader>lg',
    function()
        require('wezterm').spawn("Lazygit", { cwd = vim.fn.getcwd() })
    end,
    "Lazygit"
)
map('n', '<leader>gd',
    function()
        if next(require('diffview.lib').views) == nil then
            cmd('DiffviewOpen')
        else
            cmd('DiffviewClose')
        end
    end,
    "Git Diff"
)
map('n', '<leader>gh',
    function()
        if next(require('diffview.lib').views) == nil then
            cmd('DiffviewFileHistory')
        else
            cmd('DiffviewClose')
        end
    end,
    "Git History"
)
map('n', '<leader>gj', '<CMD>Gitsigns next_hunk<CR>', "Next Change")
map('n', '<leader>gk', '<CMD>Gitsigns prev_hunk<CR>', "Prev Change")
map('n', '<leader>gb', '<CMD>Gitsigns blame_line<CR>', "Blame Line")
map('n', '<leader>gB', '<CMD>ToggleBlame virtual<CR>', "Show Blame")
-- }}}
-- Splits{{{
map('n', '<C-h>', require('smart-splits').move_cursor_left, "Navigate Left")
map('n', '<C-j>', require('smart-splits').move_cursor_down, "Navigate Down")
map('n', '<C-k>', require('smart-splits').move_cursor_up, "Navigate Up")
map('n', '<C-l>', require('smart-splits').move_cursor_right, "Navigate Right")

map('n', '<Space>h', '<C-w>H', "Move Right")
map('n', '<Space>j', '<C-w>J', "Move Down")
map('n', '<Space>k', '<C-w>K', "Move Up")
map('n', '<Space>l', '<C-w>L', "Move Right")

map('n', 'sr', require('smart-splits').start_resize_mode, "Splits Resize")
-- }}}
-- TreeSJ{{{
map('n', '<c-s>', '<CMD>TSJToggle<CR>', "Split/Join")
-- }}}
-- Alternate-Toggler{{{
map('n', '<leader>ta', '<CMD>ToggleAlternate<CR>', "Toggle Alternate")
-- }}}
-- Project{{{
map('n', '<C-T>', '<CMD>lua require("projtasks").toggle()<CR>', "Toggle Terminal")
map('n', '<leader>pp', '<CMD>lua require("projtasks").recent()<CR>', "Run Project")
map('n', '<leader>pr', '<CMD>lua require("projtasks").run()<CR>', "Run Project")
map('n', '<leader>pb', '<CMD>lua require("projtasks").build()<CR>', "Build Project")
map('n', '<leader>pt', '<CMD>lua require("projtasks").test()<CR>', "Test Project")

map('n', '<leader>pnt', "<CMD>lua require('neotest').summary.toggle()<CR>", "Neotest Test Project")
map('n', '<leader>pnr', "<CMD>lua require('neotest').run.run()<CR>", "Neotest Run Test")
map('n', '<leader>pnf', "<CMD>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Neotest Test File")
map('n', '<leader>pno', "<CMD>lua require('neotest').output.open()<CR>", "Neotest Open Tests")
-- }}}
-- Comment{{{
map('n', '<leader>co', [[<CMD>execute "norm! o" . substitute(&commentstring, '%s', '', '')<CR>A]], "Comment Below")
map('n', '<leader>cO', [[<CMD>execute "norm! O" . substitute(&commentstring, '%s', '', '')<CR>A]], "Comment Above")

map('n', '<leader>cl',
    [[<CMD>execute "norm! A " . substitute(&commentstring, '%s', '', '')<CR>A]],
    "Comment Right"
) -- https://vi.stackexchange.com/a/19163

-- Adapted from u/alphabet_american
map('x', '<leader>C', [[y`>pgv:norm ,cc<CR>`>j^]], "Comment and Duplicate")
-- }}}
-- Folds{{{
-- }}}
-- Lsp{{{
map('n', '<leader>ls', "<CMD>LspStart<CR>", "Start Lsp")
-- }}}
-- Zen {{{
M.toggle_zen = function()
    require('lualine').hide({ unhide = vim.g.zen_mode }) ---@diagnostic disable-line (missing field warning)
    vim.cmd("Gitsigns toggle_signs")
    if not vim.g.zen_mode then
        vim.opt.showtabline = 0
        vim.opt.statusline = "%#Normal# "
        vim.cmd("norm! mz")
        vim.cmd("tabnew %")
        vim.cmd("norm! `z")
        vim.cmd [[execute ""]]
        vim.cmd.setlocal("norelativenumber")
        -- vim.cmd.setlocal("nonumber")
        -- vim.opt.signcolumn="yes:3"
    else
        vim.opt.showtabline = 2
        vim.cmd("tabclose")
        vim.opt.signcolumn = "yes:1"
    end
    vim.g.zen_mode = not vim.g.zen_mode
end
map('n', '<leader>z', M.toggle_zen, "Toggle Zen")
-- }}}
-- Quickfix{{{
map('n', '<leader>xo', '<CMD>copen<CR>', "Open QF")
map('n', '<leader>xc', '<CMD>cclose<CR>', "Close QF")
map('n', '<leader>xf', '<CMD>cfirst<CR>', "First in QF")
map('n', '<leader>xj', '<CMD>cnext<CR>', "Next in QF")
map('n', '<leader>xk', '<CMD>cprev<CR>', "Prev in QF")
-- }}}

-- CONFIG{{{

map('n', 'C', '<nop>', "")
map('n', 'Cll',
    -- Toggle LSP Lines
    function()
        local d_conf = vim.diagnostic.config
        d_conf({
            virtual_text = not d_conf().virtual_text,
            virtual_lines = not d_conf().virtual_lines
        })
    end,
    "Lsp Lines"
)

map('n', 'Crn',
    -- Toggle relative number
    function()
        cmd.set('relativenumber!')
    end,
    "Relative Number"
)

map('n', 'Cw',
    -- Toggle wrap
    function()
        cmd.set('wrap!')
        print('Wrap: ' .. tostring(vim.o.wrap))
    end,
    "Wrap"
)

map('n', 'Cba',
    -- Toggle Bufferline show all
    function()
        vim.g.bufferline_show_all = not vim.g.bufferline_show_all
        print('Bufferline Show All: ' .. tostring(vim.g.bufferline_show_all))
    end,
    "Bufferline Show All"
)

map('n', 'Cih',
    -- Toggle inlay hints
    function()
        vim.lsp.inlay_hint(0, nil)
    end,
    "Inlay Hints"
)

map('n', 'Ccc',
    -- Toggle Colorcolumn
    function()
        vim.wo.colorcolumn = (vim.wo.colorcolumn == '80' and '0' or '80')
        print("Colorcolumn: "
            .. (vim.wo.colorcolumn == '80' and "true" or "false"))
    end,
    "Colorcolumn"
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
    end,
    "Virtual Edit"
)

map('n', 'Cgb',
    -- Toggle git blame
    function()
        cmd('Gitsigns toggle_current_line_blame')
    end,
    "Git Blame"
)

map('n', 'Clv',
    -- Toggle detailed lualine
    function()
        vim.g.lualine_verbose = not vim.g.lualine_verbose
    end,
    "Lualine Verbosity"
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
                    require('wezterm').set_user_var("COLORS_NAME", choice)
                end
            end
        )
    end,
    "Change Theme"
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
    end,
    "Conceallevel"
)

map('n', 'Ccr',
    function()
        require('colorscheme').reload()
    end,
    "Reload Colorscheme"
)

map('n', 'Cd',
    -- Toggle terminal direction
    function()
        require('projtasks').toggle_terminal_direction()
    end,
    "Terminal Direction"
)

map('n', 'Cfc',
    function()
        require("nucomment").toggle_floating_comments()
    end,
    "Floating Comments"
)

-- Restart nvim
map('n', '<leader>R',
    function()
        -- '<CMD>wa<CR><CMD>SessionSave<CR><CMD>cq<CR>'
        if vim.g.zen_mode then
            M.toggle_zen()
        end
        vim.cmd.wa()
        vim.cmd.SessionSave()
        vim.cmd.cq()
    end,
    "Reload"
)


--- ABBREVIATIONS  TODO: Replace with snippets
-- email
map('ia', '@@g', '92702993+tj-moody@users.noreply.github.com', "Email")

-- datetime
m_o('ia', 'dtfull', 'strftime("%c")', { expr = true })
m_o('ia', 'dtdate', 'strftime("%m/%d/%y")', { expr = true })
m_o('ia', 'dttime', 'strftime("%H:%M")', { expr = true }) -- }}}

-- META{{{
map("n", "<leader><leader>ps", function()
    vim.cmd [[
        profile start /tmp/nvim-profile.log
        profile func *
        profile file *
    ]]
end, "Profile Start")

map("n", "<leader><leader>pe", function()
    vim.cmd [[
        profile stop
        e /tmp/nvim-profile.log
    ]]
end, "Profile End")
-- }}}

return M
