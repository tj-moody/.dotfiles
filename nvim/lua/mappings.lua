vim.g.mapleader = ","
local function m(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, }) end

--- BASICS
m('n', '<leader>.', ":vsp<CR>:Telescope find_files<CR>")

m('n', '<leader>w', ":silent write<CR>")
m('n', '<leader><leader>w', ":silent write<CR>:so<CR>:echo ' [WS]'<CR>")

m('n', '<leader>q', ":q<CR>")
m('n', '<leader>h', ":noh<CR>:ColorizerReloadAllBuffers<CR>")

m('v', 'K', ":m '<-2<CR>gv=gv")
m('v', 'J', ":m '>+1<CR>gv=gv")

m('n', '<CR>', "mmo<esc>`m")
m('n', '<S-CR>', "mmO<esc>`m")

m('v', 'p', '"0p') -- '"0pgv'

-- m('n', '<space>h', "<C-W>h")
-- m('n', '<space>j', "<C-W>j")
-- m('n', '<space>k', "<C-W>k")
-- m('n', '<space>l', "<C-W>l")
-- m('n', '<C-h>', "<C-W>h")
-- m('n', '<C-j>', "<C-W>j")
-- m('n', '<C-k>', "<C-W>k")
-- m('n', '<C-l>', "<C-W>l")

m('n', 's', ':vsp<CR>')

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
m('n', 'T', nvimtreetogglefloat)
-- Telescope
m('n', '<leader>ff', ":Telescope find_files<CR>")
m('n', '<leader>fh', ":Telescope highlights<CR>")
m('n', '<leader>fg', ":Telescope live_grep<CR>")
-- Bufferline
m('n', 'H', ":BufferLineCyclePrev<CR>")
m('n', 'L', ":BufferLineCycleNext<CR>")
m('n', '<leader>tq', ":BufferLinePickClose<CR>")
m('n', '<leader>ts', ":BufferLineSortByTabs<CR>")
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

m('n', '<C-T>', ':ToggleTerm size=40 direction=float<CR>')
m('n', '<leader>td', ':ToggleTerm size=20 direction=horizontal<CR>')
m('t', '<C-T>', [[<C-\><C-n>:q<CR>]])
-- git
m('n', '<leader>lg', ':ToggleTerm size=40 direction=float<CR>lazygit<CR>')
m('n', '<leader>gdo', ':DiffviewOpen<CR>')
m('n', '<leader>gdc', ':DiffviewClose<CR>')
-- smart-splits
m('n', '<C-h>', require('smart-splits').resize_left)
m('n', '<C-j>', require('smart-splits').resize_down)
m('n', '<C-k>', require('smart-splits').resize_up)
m('n', '<C-l>', require('smart-splits').resize_right)
-- moving between splits
-- m('n', '<C-j>', require('smart-splits').move_cursor_down)
-- m('n', '<C-h>', require('smart-splits').move_cursor_left)
-- m('n', '<C-k>', require('smart-splits').move_cursor_up)
-- m('n', '<C-l>', require('smart-splits').move_cursor_right)
m('n', '<space>j', require('smart-splits').move_cursor_down)
m('n', '<space>h', require('smart-splits').move_cursor_left)
m('n', '<space>k', require('smart-splits').move_cursor_up)
m('n', '<space>l', require('smart-splits').move_cursor_right)
-- swapping buffers between windows
-- m('n', '<space>h', require('smart-splits').swap_buf_left)
-- m('n', '<space>j', require('smart-splits').swap_buf_down)
-- m('n', '<space>k', require('smart-splits').swap_buf_up)
-- m('n', '<space>l', require('smart-splits').swap_buf_right)
-- config
local function toggle_lsp_lines()
    local d_conf = vim.diagnostic.config
    d_conf({ virtual_text = not d_conf().virtual_text })
    require('lsp_lines').toggle()
end
m('n', '<leader>ctl', toggle_lsp_lines) -- config toggle lsp lines
