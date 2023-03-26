vim.g.mapleader = ","
local function m(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, }) end
local function m_o(mode, lhs, rhs, opts) vim.keymap.set(mode, lhs, rhs, opts) end

--- BASICS
m('n', '<leader>.', ":vsp<CR>:Telescope find_files<CR>")

m('n', '<leader>w', ":silent write<CR>")
m('n', '<leader><leader>w', ":w<CR>:so<CR>")

m('n', '<leader>q', ":q<CR>")
-- m('n', '<leader>h', ":noh<CR>:ColorizerReloadAllBuffers<CR>")
m('n', '<esc>', ":noh<CR>:ColorizerReloadAllBuffers<CR>")

m('v', 'K', ":m '<-2<CR>gv=gv")
m('v', 'J', ":m '>+1<CR>gv=gv")

m('n', '<CR>', "mzo<esc>`z")
m('n', '<S-CR>', "mzO<esc>`z")

m_o("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
m_o("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

m('n', "<leader>'", ':e #<CR>')

m('n', '<leader>=', 'mzgg=G`z')

m('n', 'p', ']p')
m('v', 'p', '"0p') -- '"0pgv'

m('n', 'x', '"_x')

m('n', "J", "mzJ`z")

m('n', "<C-d>", "<C-d>zz")
m('n', "<C-u>", "<C-u>zz")

m('n', "n", "nzzzv")
m('n', "N", "Nzzzv")

m('n', 'sl', ':vsp<CR>')
m('n', 'sj', ':sp<CR>')
m('n', 'se', '<c-w>=')

local function only_buffer()
    if vim.bo.filetype == 'NvimTree' then
        vim.cmd('only')
    else
        vim.cmd('%bd!')
        vim.cmd(vim.api.nvim_replace_termcodes('normal <c-o>', true, true, true))
        vim.cmd('bd #')
    end
end
m('n', '<leader>O', only_buffer)
m('n', '<leader>o', ":silent only<CR>")

m('n', '<leader>y', '"+y')
m('v', '<leader>y', '"+y')

m('v', '<', '<gv4h')
m('v', '>', '>gv4l')

m('n', '<C-C>', '~')

--- PLUGINS
-- NvimTree
local function nvimtreetoggle()
    if vim.g.nvimtreefloat == true then
        require('config.nvim-tree').nvim_tree_setup()
        return
    end
    if vim.bo.filetype == 'NvimTree' then
        vim.cmd("NvimTreeClose")
    else
        vim.cmd("NvimTreeClose")
        vim.cmd("NvimTreeOpen")
    end
    require('hlgroups').hl_category_setup('nvim_tree', vim.g.tjtheme)
end
m('n', 't', nvimtreetoggle)
local function nvimtreetogglefloat()
    if vim.g.nvimtreefloat == true then
        vim.g.nvimtreefloat = false
        vim.cmd("NvimTreeClose")
        require('config.nvim-tree').nvim_tree_setup()
    else
        require('config.nvim-tree').nvim_tree_float_setup()
        vim.cmd("NvimTreeClose")
        vim.cmd("NvimTreeOpen")
    end
end
m('n', 'TT', nvimtreetogglefloat)
-- Telescope
m('n', '<leader>ff', ":Telescope find_files<CR>")
m('n', '<leader>fh', ":Telescope highlights<CR>")
m('n', '<leader>fg', ":Telescope live_grep<CR>")
m('n', '<leader>fk', ":Telescope keymaps<CR>")
-- Bufferline
m('n', 'H', ":BufferLineCyclePrev<CR>")
m('n', 'L', ":BufferLineCycleNext<CR>")
m('n', 'Tq', ":BufferLinePickClose<CR>")
m('n', 'Ts', ":BufferLineSortByTabs<CR>")
m('n', 'gb', ":BufferLinePick<CR>")
-- Tabs
m('n', 'T.', ':tabe %<CR>:Telescope find_files<CR>')
m('n', 'T>', ':tabe %<CR>:Telescope find_files<CR>') -- proof for typos
m('n', 'TL', ':tabnext<CR>')
m('n', 'Tl', ':tabnext<CR>')
m('n', 'TH', ':tabprevious<CR>')
m('n', 'Th', ':tabprevious<CR>')
m('n', 'TO', ':tabonly<CR>')
m('n', 'To', ':tabonly<CR>')
m('n', 'TC', ':tabclose<CR>')
m('n', 'Tc', ':tabclose<CR>')
-- Lazy
m('n', '<leader>lz', ":Lazy<CR>")
-- Toggleterm
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
m('n', '<leader>tf', ':ToggleTerm size=40 direction=float<CR>')
m('n', '<leader>tj', ':ToggleTerm size=20 direction=horizontal<CR>')
m('n', '<leader>tl', ':ToggleTerm size=60 direction=vertical<CR>')
m('t', '<C-T>', [[<C-\><C-n>:q<CR>]])
-- git
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, highlights = {
    NormalFloat = { guibg = '', guifg = '', },
    FloatBorder = { guibg = '', },
}})
local function lazygit_toggle()
  lazygit:toggle()
end
-- m('n', '<leader>lg', ':ToggleTerm size=40 direction=float<CR>lazygit<CR>')
m('n', '<leader>lg', lazygit_toggle)
m('n', '<leader>gdo', ':DiffviewOpen<CR>')
m('n', '<leader>gdc', ':DiffviewClose<CR>')
-- smart-splits
--- resize
-- m('n', '<C-s-h>', require('smart-splits').resize_left)
-- m('n', '<C-s-j>', require('smart-splits').resize_down)
-- m('n', '<C-s-k>', require('smart-splits').resize_up)
-- m('n', '<C-s-l>', require('smart-splits').resize_right)
m('n', '<space>h', require('smart-splits').resize_left)
m('n', '<space>j', require('smart-splits').resize_down)
m('n', '<space>k', require('smart-splits').resize_up)
m('n', '<space>l', require('smart-splits').resize_right)
---  moving between splits
m('n', '<C-j>', require('smart-splits').move_cursor_down)
m('n', '<C-h>', require('smart-splits').move_cursor_left)
m('n', '<C-k>', require('smart-splits').move_cursor_up)
m('n', '<C-l>', require('smart-splits').move_cursor_right)
-- m('n', '<space>j', require('smart-splits').move_cursor_down)
-- m('n', '<space>h', require('smart-splits').move_cursor_left)
-- m('n', '<space>k', require('smart-splits').move_cursor_up)
-- m('n', '<space>l', require('smart-splits').move_cursor_right)
--- swapping buffers between windows
-- m('n', '<space>h', require('smart-splits').swap_buf_left)
-- m('n', '<space>j', require('smart-splits').swap_buf_down)
-- m('n', '<space>k', require('smart-splits').swap_buf_up)
-- m('n', '<space>l', require('smart-splits').swap_buf_right)
-- treesj
m('n', '<c-s>', ':TSJToggle<CR>')
-- config
local function toggle_lsp_lines()
    local d_conf = vim.diagnostic.config
    d_conf({ virtual_text = not d_conf().virtual_text })
    require('lsp_lines').toggle()
end
m('n', 'Cll', toggle_lsp_lines) -- config toggle lsp lines
local function toggle_relative_number()
    vim.opt.relativenumber = not vim.opt.relativenumber._value
end
m('n', 'Crn', toggle_relative_number) -- config toggle lsp lines
local function toggle_wrap()
    vim.opt.wrap = not vim.opt.wrap._value
    vim.cmd([[echo " Wrap: ]] .. tostring(vim.opt.wrap._value) .. [["]])
end
m('n', 'Cw', toggle_wrap) -- config toggle lsp lines
local function toggle_bufferline_show_all()
    vim.g.bufferline_show_all = not vim.g.bufferline_show_all
    vim.cmd([[echo " Bufferline Show All: ]] .. tostring(vim.g.bufferline_show_all) .. [["]])
end
m('n', 'Cba', toggle_bufferline_show_all) -- config toggle lsp lines

-- search & replace in word
-- m('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
