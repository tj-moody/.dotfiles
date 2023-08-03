vim.g.mapleader = ","

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

--- BASICS
map('n', '<leader>.', ":vsp<CR>:Telescope find_files<CR>")

map('n', '<leader>w', ":silent write<CR>")
map('n', '<leader><leader>x', ":silent write<CR>:source <CR>")

map('n', '<leader>q', ":q<CR>")
map('n', '<esc>', ":noh<CR>:ColorizerReloadAllBuffers<CR>:echo ''<CR>")

map('v', 'K', ":m '<-2<CR>gv=gv")
map('v', 'J', ":m '>+1<CR>gv=gv")

map('n', '<CR>', "mzo<esc>`z")
map('n', '<S-CR>', "mzO<esc>`z")

m_o("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
m_o("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map('n', '<leader>=', 'mzgg=G`z')

map('n', 'p', ']p')
map('v', 'p', '"0p') -- '"0pgv'

map('n', 'x', '"_x')

map('n', "J", "mzJ`z")

map('n', "<C-d>", "<C-d>zz")
map('n', "<C-u>", "<C-u>zz")

map('n', "n", "nzzzv")
map('n', "N", "Nzzzv")

map('n', 'sl', ':vsp<CR>')
map('n', 'sj', ':sp<CR>')
map('n', 'se', '<c-w>=')

map('v', 'V', 'j')

map('n', 'gV', "`[v`]")

local escape_code = vim.api.nvim_replace_termcodes(
    "<Esc>",
    false, false, true
)
local backspace_code = vim.api.nvim_replace_termcodes(
    "<BS>",
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
m_o('i', '<BS>',
    function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        local before_cursor_is_whitespace = vim.api.nvim_get_current_line()
            :sub(0, col)
            :match("^%s*$")

        if not before_cursor_is_whitespace then
            return require('nvim-autopairs').autopairs_bs()
        end
        if line == 1 then
            return viml_backspace()
        end
        local correct_indent = require("nvim-treesitter.indent").get_indent(line)
        local current_indent = vim.fn.indent(line)
        local previous_line_is_whitespace = vim.api.nvim_buf_get_lines(
            0, line - 2, line - 1, false
        )[1]:match("^%s*$")
        if current_indent == correct_indent then
            if previous_line_is_whitespace then
                return viml_backspace()
            end
            return backspace_code
        elseif current_indent > correct_indent then
            return escape_code .. "==0wi"
        end
        return backspace_code
    end,
    { expr = true, noremap = true, replace_keycodes = false }
)
map('i', '<S-BS>', '<BS>')

-- adapted from https://vi.stackexchange.com/a/12870
map({ 'n', 'v' }, 'gj',
    -- next indent
    function()
        -- Get the current cursor position
        local current_line, column = unpack(vim.api.nvim_win_get_cursor(0))
        local match_line = current_line
        local match_indent = false

        local buf_length = vim.api.nvim_buf_line_count(0)

        -- Look for a line with the same indent level without going out of the buffer
        while (not match_indent) and (match_line ~= buf_length) do
            match_line = match_line + 1

            local match_line_str = vim.api.nvim_buf_get_lines(0, match_line - 1, match_line, false)[1] .. ' '
            -- local stripped_match_line_str = match_line_str:gsub("%s+", "")
            local match_line_is_whitespace = match_line_str:match("^%s*$")

            match_indent = (vim.fn.indent(match_line) <= vim.fn.indent(current_line))
                and (not match_line_is_whitespace)
            -- and (stripped_match_line_str ~= "end")
            -- and (stripped_match_line_str ~= "}")
        end

        -- If a line is found go to this line
        if match_indent or match_line == buf_length then
            vim.fn.cursor({ match_line, column + 1 })
        end
    end
)

map({ 'n', 'v' }, 'gk',
    -- prev_indent
    function()
        -- Get the current cursor position
        local current_line, column = unpack(vim.api.nvim_win_get_cursor(0))
        local match_line = current_line
        local match_indent = false

        local buf_length = vim.api.nvim_buf_line_count(0)

        -- Look for a line with the same indent level without going out of the buffer
        while (not match_indent) and (match_line ~= buf_length) do
            match_line = match_line - 1

            local match_line_str = vim.api.nvim_buf_get_lines(0, match_line - 1, match_line, false)[1] .. ' '
            -- local stripped_match_line_str = match_line_str:gsub("%s+", "")
            local match_line_is_whitespace = match_line_str:match("^%s*$")

            match_indent = (vim.fn.indent(match_line) <= vim.fn.indent(current_line))
                and (not match_line_is_whitespace)
            -- and (stripped_match_line_str ~= "end")
            -- and (stripped_match_line_str ~= "}")
        end

        -- If a line is found go to this line
        if match_indent or match_line == buf_length then
            vim.fn.cursor({ match_line, column + 1 })
        end
    end
)

map('n', '<leader>O',
    -- Delete all other buffers
    function()
        if vim.bo.filetype == 'NvimTree' then
            vim.cmd('only')
        else
            vim.cmd('%bd!')
            vim.cmd(vim.api.nvim_replace_termcodes(
                'normal <c-o>',
                true, true, true
            ))
            vim.cmd('bd #')
        end
    end
)
map('n', '<leader>o', ":silent only<CR>")

map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')

map('v', '<', '<gv4h')
map('v', '>', '>gv4l')

map('n', '<leader>ct',
    function()
        vim.ui.select(safe_require('colorscheme').themes_list, {
                prompt = "Choose theme:",
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

-- Restart nvim
map('n', '<leader>R', ':wa<CR>:cq<CR>')

--- PLUGINS
-- NvimTree

map('n', 't',
    -- Toggle NvimTree
    function()
        if vim.g.nvimtreefloat == true then
            safe_require('config.nvim-tree').nvim_tree_setup()
            return
        end
        if vim.bo.filetype == 'NvimTree' then
            vim.cmd("NvimTreeClose")
        else
            vim.cmd("NvimTreeClose")
            vim.cmd("NvimTreeOpen")
        end
        safe_require('colorscheme').setup('nvim_tree')
    end
)

map('n', 'TT',
    -- Toggle NvimTree float
    function()
        if vim.g.nvimtreefloat == true then
            vim.g.nvimtreefloat = false
            vim.cmd("NvimTreeClose")
            safe_require('config.nvim-tree').nvim_tree_setup()
        else
            safe_require('config.nvim-tree').nvim_tree_float_setup()
            vim.cmd("NvimTreeClose")
            vim.cmd("NvimTreeOpen")
        end
    end
)

-- Telescope
map('n', '<leader>ff', ":Telescope smart_open<CR>")
-- m('n', '<leader>ff', ":Telescope find_files<CR>")
map('n', '<leader>fh', ":Telescope highlights<CR>")
map('n', '<leader>fg', ":Telescope live_grep<CR>")
map('n', '<leader>fk', ":Telescope keymaps<CR>")
-- Bufferline
map('n', 'H', ":BufferLineCyclePrev<CR>")
map('n', 'L', ":BufferLineCycleNext<CR>")
map('n', 'Tq', ":BufferLinePickClose<CR>")
map('n', 'Ts', ":BufferLineSortByTabs<CR>")
map('n', 'gb', ":BufferLinePick<CR>")

-- Tabs
map('n', 'T.', ':tabe %<CR>:Telescope find_files<CR>')
map('n', 'T>', ':tabe %<CR>:Telescope find_files<CR>') -- proof for typos
map('n', 'TL', ':tabnext<CR>')
map('n', 'Tl', ':tabnext<CR>')
map('n', 'TH', ':tabprevious<CR>')
map('n', 'Th', ':tabprevious<CR>')
map('n', 'TO', ':tabonly<CR>')
map('n', 'To', ':tabonly<CR>')
map('n', 'TC', ':tabclose<CR>')
map('n', 'Tc', ':tabclose<CR>')

-- Lazy
map('n', '<leader>lz', ":Lazy<CR>")

-- Toggleterm

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

-- m('n', '<C-T>', ':ToggleTerm size=40 direction=float<CR>')
map('n', '<leader>tf', ':ToggleTerm size=40 direction=float<CR>')
map('n', '<leader>tj', ':ToggleTerm size=20 direction=horizontal<CR>')
map('n', '<leader>tl', ':ToggleTerm size=60 direction=vertical<CR>')
map('t', '<C-T>', [[<C-\><C-n>:q<CR>]])

-- git
local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    highlights = {
        NormalFloat = { guibg = '', guifg = '' },
        FloatBorder = { guibg = '' },
    }
})
-- m('n', '<leader>lg', ':ToggleTerm size=40 direction=float<CR>lazygit<CR>')
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
map('n', '<leader>gj', ':Gitsigns next_hunk<CR>')
map('n', '<leader>gk', ':Gitsigns prev_hunk<CR>')
map('n', '<leader>gb', ':Gitsigns blame_line<CR>')

-- smart-splits
map('n', '<space>h', require('smart-splits').resize_left)
map('n', '<space>j', require('smart-splits').resize_down)
map('n', '<space>k', require('smart-splits').resize_up)
map('n', '<space>l', require('smart-splits').resize_right)

map('n', '<C-j>', require('smart-splits').move_cursor_down)
map('n', '<C-h>', require('smart-splits').move_cursor_left)
map('n', '<C-k>', require('smart-splits').move_cursor_up)
map('n', '<C-l>', require('smart-splits').move_cursor_right)

-- treesj
map('n', '<c-s>', ':TSJToggle<CR>')

-- alternate-toggler
map('n', '<leader>ta', ':ToggleAlternate<CR>')

-- project
map('n', '<leader>pr', ':ProjtasksRun<CR>')
map('n', '<leader>pp', ':ProjtasksToggle<CR>')
map('n', '<leader>pt', ':ProjtasksTest<CR>')

--- CONFIG

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
        vim.o.relativenumber = not vim.o.relativenumber
    end
)

map('n', 'Cw',
    -- Toggle wrap
    function()
        vim.o.wrap = not vim.o.wrap
        print("Wrap: " .. tostring(vim.o.wrap))
    end
)

map('n', 'Cba',
    -- Toggle Bufferline show all
    function()
        vim.g.bufferline_show_all = not vim.g.bufferline_show_all
        print("Bufferline Show All: " .. tostring(vim.g.bufferline_show_all))
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
        local cc = vim.wo.colorcolumn
        cc = cc == '80' and '0' or '80'
    end
)

map('n', 'Cve',
    -- Toggle virtual edit
    function()
        if vim.o.virtualedit == 'all' then
            vim.o.virtualedit = ''
        else
            vim.o.virtualedit = 'all'
        end
        if vim.o.virtualedit == 'all' then
            print("Virtual Edit: true")
        else
            print("Virtual Edit: false")
        end
    end
)

map('n', 'Cgb',
    -- Toggle git blame
    function()
         vim.cmd("Gitsigns toggle_current_line_blame")
    end
)

map('n', 'Clv',
    -- Toggle detailed lualine
    function()
        vim.g.lualine_verbose = not vim.g.lualine_verbose
        print("Verbose Lualine: " .. tostring(vim.g.lualine_verbose))
    end
)

-- search & replace in word
-- m('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map('i', '<ScrollWheelLeft>', '')
map('i', '<ScrollWheelRight>', '')
map('n', '<ScrollWheelLeft>', '')
map('n', '<ScrollWheelRight>', '')
map('v', '<ScrollWheelLeft>', '')
map('v', '<ScrollWheelRight>', '')
