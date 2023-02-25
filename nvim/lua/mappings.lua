vim.g.mapleader = ","
local function m(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, }) end

--- BASICS
m('n', '<leader>.', ":vsp<CR>:Telescope find_files<CR>")

m('n', '<leader>w', ":silent write<CR>")
m('n', '<leader><leader>w', ":silent write<CR>:so<CR>:echo ' [WS]'<CR>")

m('n', '<leader>q', ":q<CR>")
m('n', '<leader>h', ":noh<CR>")

m('v', 'K', ":m '<-2<CR>gv=gv")
m('v', 'J', ":m '>+1<CR>gv=gv")

m('n', '<CR>', "mmo<esc>`m")
m('n', '<S-CR>', "mmO<esc>`m")

m('n', '<space>h', "<C-W>h")
m('n', '<space>j', "<C-W>j")
m('n', '<space>k', "<C-W>k")
m('n', '<space>l', "<C-W>l")

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
    if vim.bo.filetype == 'NvimTree' then
        vim.cmd("NvimTreeClose")
    else
        vim.cmd("NvimTreeClose")
        vim.cmd("NvimTreeOpen")
    end
end
m('n', 't', nvimtreetoggle)
m('n', 'T', ':NvimTreeClose<CR>:NvimTreeOpen<CR>:only<CR>')
-- Telescope
m('n', '<leader>ff', ":Telescope find_files<CR>")
m('n', '<leader>fh', ":Telescope highlights<CR>")
m('n', '<leader>fg', ":Telescope find_files<CR>")
-- Bufferline
m('n', 'H', ":BufferLineCyclePrev<CR>")
m('n', 'L', ":BufferLineCycleNext<CR>")
m('n', '<leader>tq', ":BufferLinePickClose<CR>")
